using UnityEngine;

public class Offset_Anim : MonoBehaviour
{

    void Awake()
    {
        var desired_play_time = Random.Range(0.0f, 7.0f);
        this.GetComponent<Animation>()["Sampler_tank"].time = desired_play_time;
        this.GetComponent<Animation>().Play("Sampler_tank");
    }
}