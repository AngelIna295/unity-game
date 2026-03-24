using UnityEngine;

public class DoorsTrigger : MonoBehaviour
{
    public Animator door1;
    public Animator door2;

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player") || other.CompareTag("Creature"))
        {
            door1.SetBool("isOpen", true);
            door2.SetBool("isOpen", true);
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player") || other.CompareTag("Creature"))
        {
            door1.SetBool("isOpen", false);
            door2.SetBool("isOpen", false);
        }
    }
}
