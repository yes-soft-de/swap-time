<?php

namespace App\Request;

class CreateInteractionRequest
{
    private $id;
    private $userID;
    private $swapItemID;
    private $type;

     /**
     * @return mixed
     */
    public function getId(): ?int
    {
        return $this->id;
    }

    /**
     * @return mixed
     */
    public function getUserID()
    {
        return $this->userID;
    }

    /**
     * @param mixed $userID
     */
    public function setUserID($userID): void
    {
        $this->userID = $userID;
    }

    /**
     * @return mixed
     */
    public function getSwapItemID()
    {
        return $this->swapItemID;
    }

    /**
     * @param mixed $swapItemID
     */
    public function setSwapItemID($swapItemID): void
    {
        $this->swapItemID = $swapItemID;
    }

    /**
     * @return mixed
     */ 
    public function getType()
    {
        return $this->type;
    }

    /**
     * @param mixed $type
     */
    public function setType($type): void
    {
        $this->type = $type;
    }


}