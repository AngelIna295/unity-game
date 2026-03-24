using UnityEngine;

public class Animation_door : MonoBehaviour
{

    Animator anim;
    public AudioClip doorOpenClip;
    public AudioClip doorCloseClip;

    void Start()
    {
        anim = GetComponent<Animator>();
    }
    void OnTriggerEnter(Collider other)
    {
        if (other.GetComponent<Collider>().tag == "Player")
        {
            anim.SetBool("Open", true);
            GetComponent<AudioSource>().clip = doorOpenClip;
            GetComponent<AudioSource>().Play();
        }
    }
    void OnTriggerExit(Collider other)
    {
        if (other.GetComponent<Collider>().tag == "Player")
        {
            anim.SetBool("Open", false);
            GetComponent<AudioSource>().clip = doorCloseClip;
            GetComponent<AudioSource>().Play();
        }
    }
}
