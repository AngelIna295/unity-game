using UnityEngine;

public class Btn_door : MonoBehaviour
{
    public Animator door1;
    public Animator door2;
    public static bool isOpen = false;

    void Start()
    {
        
    }
    public void OpenCLose()
    {
        if (isOpen == false && Energie.isEmpty == false)
        {
            door1.SetBool("isOpen", true);
            door2.SetBool("isOpen", true);
            isOpen = true;
        }
        else if (isOpen == true && Energie.isEmpty == false)
        {
            door1.SetBool("isOpen", false);
            door2.SetBool("isOpen", false);
            isOpen = false;
        }
    }
}
