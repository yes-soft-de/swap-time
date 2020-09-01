<?php

namespace App\Repository;

use App\Entity\SwapItemEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method SwapItemEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method SwapItemEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method SwapItemEntity[]    findAll()
 * @method SwapItemEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class SwapItemEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, SwapItemEntity::class);
    }

    public function getItems()
    {
        return $this->createQueryBuilder('swapItems')

            ->select('swapItems.id', 'swapItems.name', 'swapItems.category', 'swapItems.tag', 'swapItems.description',
                'swapItems.mainImage', 'swapItems.userID')

            ->orderBy('swapItems.id', 'ASC')

            ->getQuery()
            ->getResult();
    }

    public function getItemByID($id)
    {
        return $this->createQueryBuilder('swapItems')
            ->select('swapItems.id', 'swapItems.name', 'swapItems.category', 'swapItems.tag', 'swapItems.description',
                'swapItems.mainImage', 'swapItems.userID')

            ->andWhere('swapItems.id=:id')
            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getItemByUserID($userID)
    {
        return $this->createQueryBuilder('swapItems')
            ->select('swapItems.id', 'swapItems.name', 'swapItems.category', 'swapItems.tag', 'swapItems.description',
                'swapItems.mainImage', 'swapItems.userID')

            ->andWhere('swapItems.userID=:userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getResult();
    }
}
