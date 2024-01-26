ArrayList<ArrayList<PVector>> mapping(ArrayList<ArrayList<PVector>> points){
    ArrayList<ArrayList<PVector>> image = new ArrayList<ArrayList<PVector>>();
    for (int i = 0; i < points.size(); ++i) {
        ArrayList<PVector> col = points.get(i);
        ArrayList<PVector> wCol = new ArrayList<PVector>();
        for (int j = 0; j < col.size(); ++j) {
            PVector vec = col.get(j);
            Complex z = new Complex(vec.x/divideConst, vec.y/divideConst);
            Complex w = f(z);
            wCol.add(new PVector(w.getX()*divideConst, w.getY()*divideConst));
        }
        image.add(wCol);
    }
    return image;
}

Complex f(Complex z){
    //Squared
    //Complex w = z.power(2);

    //Complex w = z.add(new Complex(1,0)).reciprocal().power(2);
    //Complex w = z.power(2).reciprocal().add(z.times(5));
    //Complex w = z.times(2);

    //Recipocal
    Complex w = z.reciprocal();

    //Multipy by i
    //Complex w = z.timesI();

    //Complex w = new Complex();
    //w.setPolar(pow(z.getR(),2),z.getAngle());
    //w.setPolar(1/z.getR(),z.getAngle());
    //w.printCartesian();
    return w;
}

ArrayList<ArrayList<ArrayList<PVector>>> generateFrame(ArrayList<ArrayList<PVector>> start, ArrayList<ArrayList<PVector>> end){
    ArrayList<ArrayList<ArrayList<PVector>>> animation = new ArrayList<ArrayList<ArrayList<PVector>>>();
    for (int i = 0; i < start.size(); ++i) {
        ArrayList<PVector> startcolcol = start.get(i);
        ArrayList<PVector> endcolcol = end.get(i);
        ArrayList<ArrayList<PVector>> resultCol = new ArrayList<ArrayList<PVector>>();

        for (int j = 0; j < startcolcol.size(); ++j) {
            PVector first = startcolcol.get(j);
            PVector last = endcolcol.get(j);
            ArrayList<PVector> locations = new ArrayList<PVector>();
            for (int k = 0; k < no_of_Frames; ++k) {
                float cordX ,cordY;
                if (first.x == last.x) {
                    cordX = first.x;
                } else {
                    cordX = map(float(k),0,no_of_Frames,first.x,last.x);
                }
                if (first.y == last.y){
                    cordY = first.y;
                } else {
                    cordY = map(float(k),0,no_of_Frames,first.y,last.y);
                }
                locations.add(new PVector(cordX,cordY));
            }
            resultCol.add(locations);
        }
        animation.add(resultCol);
    }
    return animation;
}