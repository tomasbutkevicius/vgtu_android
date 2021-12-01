package com.example.a2pvz;

import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentActivity;
import androidx.fragment.app.FragmentTransaction;

import java.util.Arrays;
import java.util.List;

public class MainActivity extends FragmentActivity {

    public String pasirinktaFunkcija;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        List<String> strings = Arrays.asList("Funkcija 1", "Funkcija 2", "Funkcija 3");

        final ListView list = findViewById(R.id.sarasas);
        ArrayAdapter<String> arrayAdapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, strings);

        list.setAdapter(arrayAdapter);
        list.setOnItemClickListener((parent, view, position, id) -> {
            pasirinktaFunkcija=(String) list.getItemAtPosition(position);
            openFragment(new FunctionFragment());
        });
    }

    private void openFragment(Fragment fragment){
        Bundle bundle = new Bundle();
        bundle.putString("funkcija", String.valueOf(pasirinktaFunkcija));// atiduodu string
        fragment.setArguments(bundle);

        FragmentTransaction fragmentTransaction = getSupportFragmentManager().beginTransaction();//GAL  getFragmentManager();

        fragmentTransaction.replace(R.id.frameLayout, fragment);
        fragmentTransaction.commit();
    }
}