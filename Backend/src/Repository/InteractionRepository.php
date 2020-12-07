<?php

namespace App\Repository;

use App\Entity\Interaction;
use App\Entity\SwapItemEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method Interaction|null find($id, $lockMode = null, $lockVersion = null)
 * @method Interaction|null findOneBy(array $criteria, array $orderBy = null)
 * @method Interaction[]    findAll()
 * @method Interaction[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class InteractionRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Interaction::class);
    }

    public function getAll($id)
    {
        return  $res= $this->createQueryBuilder('interaction')
        ->andWhere('interaction.swapItemID = :id')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
    }

    public function getInteractionWithUser($animeID, $userID)
    {
        return  $res= $this->createQueryBuilder('interaction')
        ->andWhere('interaction.swapItemID = :swapItem')
        ->andWhere('interaction.userID  = :userID')
        ->setParameter('swapItem', $animeID)
        ->setParameter('userID', $userID)
        ->getQuery()
        ->getResult();
    }

    public function getAllLikes($id)
    {
        // Like = 1
         $res= $this->createQueryBuilder('interaction')
        ->andWhere('interaction.swapItemID = :id')
        ->andWhere('interaction.type = 1')
        ->select('count(interaction.type) as Like')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
       
        return $res;
    }

    public function getAllDisLikes($id)
    {
        // disLike = 2
         $res= $this->createQueryBuilder('interaction')
        ->andWhere('interaction.swapItemID = :id')
        ->andWhere('interaction.type = 2')
        ->select('count(interaction.type) as DisLike')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
       
        return $res;
    }

    public function getAllLove($id)
    {
        // love = 3
        return $this->createQueryBuilder('interaction')
            ->select('count(interaction.type)')

            ->andWhere('interaction.swapItemID = :id')
            ->andWhere('interaction.type = 3')
            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getAllInteractions($id)
    {
        //count all interaction
         $res= $this->createQueryBuilder('interaction')
        ->andWhere('interaction.swapItemID = :id')
        ->select('count(interaction.type) as CountAllInteraction')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
       
        return $res;
    }

    public function countInteractions($id)
    {
        return [
            $this->getAllLikes($id),
            $this->getAllDisLikes($id),
            $this->getAllLove($id),
            $this->getAllInteractions($id)
        ];
    }

    public function checkUserLoved($swapItemID, $userID)
    {
        return $this->createQueryBuilder('interaction')
            ->select('count(interaction.type)', 'interaction.id')

            ->andWhere('interaction.swapItemID = :swapItemID')
            ->andWhere('interaction.userID = :userID')
            ->andWhere('interaction.type = 3')

            ->setParameter('swapItemID', $swapItemID)
            ->setParameter('userID', $userID)
            ->groupBy('interaction.id')

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getUserInteraction($userID)
    {
        return  $res= $this->createQueryBuilder('interaction')
            ->select('interaction.swapItemID', 'interaction.date', 'swapItem.name', 'swapItem.mainImage', 'swapItem.specialLink')

            ->leftJoin(
                SwapItemEntity::class,              //Entity
                'swapItem',                        //Alias
                Join::WITH,              //Join Type
                'swapItem.id = interaction.swapItemID'  //Join Column
            )

            ->andWhere('interaction.userID  = :userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getResult();
    }
}
