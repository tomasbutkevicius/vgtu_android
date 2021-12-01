package com.example.a2pvz;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.fragment.app.Fragment;
import com.jjoe64.graphview.GraphView;
import com.jjoe64.graphview.series.DataPoint;
import com.jjoe64.graphview.series.LineGraphSeries;

public class FunctionFragment extends Fragment {

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        String pasirinktaFunkcija = getArguments().getString("funkcija");

        View view = inflater.inflate(R.layout.function, container, false);
        GraphView linegraph = view.findViewById(R.id.line_graph);

        DataPoint[] koordinates = new DataPoint[5];

        if(pasirinktaFunkcija == "Funkcija 1") {
            for (int i = 0; i < 5; i++) {
                koordinates[i] = new DataPoint(i, Funkcija1(i));
            }
        }
        else{
            for (int i = 0; i < 5; i++) {
                koordinates[i] = new DataPoint(i, Funkcija1(i));
            }
        }

        LineGraphSeries<DataPoint> lineSeries = new LineGraphSeries<>(koordinates);
        linegraph.addSeries(lineSeries);
        return view;
    }

    double Funkcija1(double x)
    // y = cos(x)+x*x
    {
        return Math.cos(x)+Math.pow(x,2);
    }
}