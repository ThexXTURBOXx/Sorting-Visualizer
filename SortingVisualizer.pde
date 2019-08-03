import java.util.LinkedList;
import java.util.Arrays;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.List;
import java.util.Random;
import processing.sound.*;

public static final int TPS = 30;
public boolean sound = false;
public int elements = 1000;
public float steps = 5;
public static Sorter sorter;
public boolean fin = false;
public Random random = new Random();
public Integer[] arr;
public TriOsc triangle = new TriOsc(this);
public Integer[] arr1;
public Integer[] sorted;
public long time;
public ConcurrentLinkedQueue<ArrayChange> arrayChanges = new ConcurrentLinkedQueue();
private float widthPerElement;

void setup() {
        size(1000, 1000);
        triangle.amp(sound ? 1 : 0);
        arr = new Integer[elements];
        arr1 = new Integer[elements];
        widthPerElement = width / (float) arr.length;
}

void initArray() {
        Random r = new Random();
        for (int i = 0; i < arr.length; i++) {
                int ran = r.nextInt();
                arr[i] = ran;
                arrayChanges.add(new ArrayChange(i, ran, false));
        }
        for (int i = 0; i < 100; i++) {
                arrayChanges.add(new ArrayChange(0, 0));
        }
        long start = System.nanoTime();
        switch(sorter) {
        case MERGE:
                thread("mergeSort");
                break;
        case INSERTION:
                thread("insertionsort");
                break;
        case QUICK:
                thread("quicksort");
                break;
        case HEAP:
                thread("heapsort");
                break;
        case BOGO:
                sorted = new Integer[arr.length];
                for (int i = 0; i < arr.length; i++)
                        sorted[i] = arr[i];
                Arrays.sort(sorted);
                break;
        case BUBBLE:
                thread("bubblesort");
                break;
        case SLOW:
                thread("slowsort");
                break;
        case COMB:
                thread("combsort");
                break;
        case COCKTAIL:
                thread("cocktailsort");
                break;
        case STOOGE:
                thread("stoogesort");
                break;
        case SMOOTH:
                thread("smoothsort");
                break;
        }
        time = System.nanoTime() - start;
}

void draw() {
        //frameRate(TPS);
        background(255);
        if (sorter == null)
                return;
        noStroke();
        colorMode(HSB);
        fill(0);
        text(sorter.name, 0, 16);
        text("Steps/Frame: " + Math.ceil(steps) + " (" + steps + ")", 0, 32);
        text("FPS: " + frameRate, 0, 48);
        for (int i = 0; i < arr1.length; i++) {
                Integer h = arr1[i];
                if (h == null)
                        continue;
                fill(map(h, Integer.MIN_VALUE, Integer.MAX_VALUE, 0, 255), 255, 255);
                rect(i * widthPerElement, height, widthPerElement, -map(h, Integer.MIN_VALUE, Integer.MAX_VALUE, 1, height));
        }
        for (int i = 0; i < steps; i++) {
                //if (!fin) {
                        if (sorter == Sorter.BOGO) {
                                if (fin)
                                        break;
                                if (!arrayChanges.isEmpty()) {
                                        ArrayChange act = arrayChanges.poll();
                                        if (act.swap) {
                                                swap(arr1, act.l, act.r);
                                        } else {
                                                arr1[act.l] = act.r;
                                        }
                                        triangle.freq(map(arr1[act.l], Integer.MIN_VALUE, Integer.MAX_VALUE, 200, 20000));
                                        triangle.play();
                                        continue;
                                } else {
                                        triangle.stop();
                                }
                                swap(arr1, random.nextInt(arr1.length), random.nextInt(arr1.length));
                                boolean flagg = false;
                                for (Integer j : arr1) {
                                        if (j == null) {
                                                flagg = true;
                                                break;
                                        }
                                }
                                if (!flagg && isEqual(arr1, sorted)) {
                                        fin = true;
                                }
                        } else {
                                if (!arrayChanges.isEmpty()) {
                                        if (arrayChanges.peek() == null)
                                                continue;
                                        ArrayChange act = arrayChanges.poll();
                                        if (act.swap) {
                                                swap(arr1, act.l, act.r);
                                        } else {
                                                arr1[act.l] = act.r;
                                        }
                                        triangle.freq(map(arr1[act.l], Integer.MIN_VALUE, Integer.MAX_VALUE, 200, 20000));
                                        triangle.play();
                                        //System.out.println(act.l + "  " + act.r);
                                } else {
                                        triangle.stop();
                                        fin = true;
                                        //text(Arrays.toString(arr1), 0, 48);
                                }
                        }
                /*} else {
                        fill(0);
                        text("Finished", 0, 64);
                        text("Time needed: " + time + "ns", 0, 80);
                        triangle.stop();
                        break;
                }*/
        }
}

boolean isEqual(Integer[] arr1, Integer[] arr2) {
        for (int i = 0; i < arr1.length; i++) {
                if (arr1[i] != arr2[i] && !arr1[i].equals(arr2[i])) {
                        return false;
                }
        }
        return true;
}

void keyReleased() {
        if (key == '+') {
                steps *= 2;
        } else if (key == '-') {
                steps /= 2;
        } else if (key == 't') {
                sound = !sound;
                triangle.amp(sound ? 1 : 0);
        }
        fin = false;
        boolean init = true;
        if (!arrayChanges.isEmpty())
                return;
        if (key == 'q') {
                sorter = Sorter.QUICK;
        } else if (key == 'm') {
                sorter = Sorter.MERGE;
        } else if (key == 'i') {
                sorter = Sorter.INSERTION;
        } else if (key == 'h') {
                sorter = Sorter.HEAP;
        } else if (key == 'b') {
                sorter = Sorter.BOGO;
        } else if (key == 'n') {
                sorter = Sorter.BUBBLE;
        } else if (key == 's') {
                sorter = Sorter.SLOW;
        } else if (key == 'c') {
                sorter = Sorter.COMB;
        } else if (key == 'v') {
                sorter = Sorter.COCKTAIL;
        } else if (key == 'd') {
                sorter = Sorter.STOOGE;
        } else if (key == 'f') {
                sorter = Sorter.SMOOTH;
        } else {
                init = false;
        }
        if (init)
                initArray();
}
