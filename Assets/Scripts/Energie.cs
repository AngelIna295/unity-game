using UnityEngine;

public class Energie : MonoBehaviour
{
    public Animator D_Left1;
    public Animator D_Right1;
    public Animator D_Left2;
    public Animator D_Right2;
    public float energie = 100f;
    public static bool isEmpty = false;

    private void Update()
    {
        bool door1Closed = Btn_door.isOpen == false;
        bool door2Closed = Btn_door2.isOpen == false;

        float consumptionRate = 0f;

        if (door1Closed && door2Closed)
        {
            consumptionRate = 5f;
        }
        else if (door1Closed || door2Closed)
        {
            consumptionRate = 2f;
        }

        energie -= (consumptionRate / 60f) * Time.deltaTime;
        energie = Mathf.Clamp(energie, 0f, 100f);

        if (energie <= 0f && !isEmpty)
        {
            isEmpty = true;

            // Открываем все двери, независимо от состояния
            D_Left1.SetBool("isOpen", true);
            D_Right1.SetBool("isOpen", true);
            D_Left2.SetBool("isOpen", true);
            D_Right2.SetBool("isOpen", true);

            Btn_door.isOpen = true;
            Btn_door2.isOpen = true;
        }
    }
}