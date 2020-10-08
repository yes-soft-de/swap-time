<?php

namespace App\Response;

class CountInteractionResponse
{

    public $countInteraction;

    /**
     * @param mixed $countInteraction
     */
    public function setCountInteraction($countInteraction): void
    {
        $this->countInteraction = $countInteraction;
    }
   

}