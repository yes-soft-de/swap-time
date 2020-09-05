<?php

namespace App\Entity;

use App\Repository\SwapEntityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=SwapEntityRepository::class)
 */
class SwapEntity
{
    /**
     * @ORM\Id()
     * @ORM\GeneratedValue()
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="date")
     */
    private $date;

    /**
     * @ORM\Column(type="string", length=300)
     */
    private $userIdOne;

    /**
     * @ORM\Column(type="string", length=300)
     */
    private $userIdTwo;

    /**
     * @ORM\Column(type="integer")
     */
    private $swapItemIdOne;

    /**
     * @ORM\Column(type="integer")
     */
    private $swapItemIdTwo;

    /**
     * @ORM\Column(type="string", length=12, nullable=true)
     */
    private $cost;

    /**
     * @ORM\Column(type="string", length=300, nullable=true)
     */
    private $roomID;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $status;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDate(): ?\DateTimeInterface
    {
        return $this->date;
    }

    public function setDate(\DateTimeInterface $date): self
    {
        $this->date = $date;

        return $this;
    }

    public function getUserIdOne(): ?string
    {
        return $this->userIdOne;
    }

    public function setUserIdOne(string $userIdOne): self
    {
        $this->userIdOne = $userIdOne;

        return $this;
    }

    public function getUserIdTwo(): ?string
    {
        return $this->userIdTwo;
    }

    public function setUserIdTwo(string $userIdTwo): self
    {
        $this->userIdTwo = $userIdTwo;

        return $this;
    }

    public function getSwapItemIdOne(): ?int
    {
        return $this->swapItemIdOne;
    }

    public function setSwapItemIdOne(int $swapItemIdOne): self
    {
        $this->swapItemIdOne = $swapItemIdOne;

        return $this;
    }

    public function getSwapItemIdTwo(): ?int
    {
        return $this->swapItemIdTwo;
    }

    public function setSwapItemIdTwo(int $swapItemIdTwo): self
    {
        $this->swapItemIdTwo = $swapItemIdTwo;

        return $this;
    }

    public function getCost(): ?string
    {
        return $this->cost;
    }

    public function setCost(?string $cost): self
    {
        $this->cost = $cost;

        return $this;
    }

    public function getRoomID(): ?string
    {
        return $this->roomID;
    }

    public function setRoomID(?string $roomID): self
    {
        $this->roomID = $roomID;

        return $this;
    }

    public function getStatus(): ?string
    {
        return $this->status;
    }

    public function setStatus(?string $status): self
    {
        $this->status = $status;

        return $this;
    }
}
