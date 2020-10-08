<?php

namespace App\Request;

class UpdateInteractionRequest
{
    private $id;
    private $userID;
    private $swapItem;
    private $type;

     /**
     * @return mixed
     */
    public function getId(): ?int
    {
        return $this->id;
    }

    /**
     * @param mixed $id
     */
    public function setId($id): void
    {
        $this->id = $id;
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
    public function getSwapItem()
    {
        return $this->swapItem;
    }

    /**
     * @param mixed $swapItem
     */
    public function setSwapItem($swapItem): void
    {
        $this->swapItem = $swapItem;
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