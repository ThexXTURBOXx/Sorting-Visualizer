public class ArrayChange {

public int l, r;
public boolean swap;

public ArrayChange(int l, int r) {
        this(l, r, true);
}

public ArrayChange(int l, int r, boolean swap) {
        this.l = l;
        this.r = r;
        this.swap = swap;
}

}
