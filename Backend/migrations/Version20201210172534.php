<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20201210172534 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE comment_entity (id INT AUTO_INCREMENT NOT NULL, comment LONGTEXT NOT NULL, date DATETIME NOT NULL, user_id VARCHAR(300) NOT NULL, swap_item_id INT NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE image_entity (id INT AUTO_INCREMENT NOT NULL, image VARCHAR(255) NOT NULL, swap_item_id INT NOT NULL, special_link TINYINT(1) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE interaction (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, swap_item_id INT NOT NULL, type INT NOT NULL, creation_date DATE DEFAULT NULL, date DATETIME DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE report_entity (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, swap_item_id INT NOT NULL, date DATE NOT NULL, description LONGTEXT DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE setting_entity (id INT AUTO_INCREMENT NOT NULL, upload_sub_folder VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE swap_entity (id INT AUTO_INCREMENT NOT NULL, date DATE NOT NULL, user_id_one VARCHAR(300) NOT NULL, user_id_two VARCHAR(300) NOT NULL, swap_item_id_one INT NOT NULL, swap_item_id_two INT NOT NULL, cost VARCHAR(12) DEFAULT NULL, room_id VARCHAR(300) DEFAULT NULL, status VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE swap_item_entity (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(255) NOT NULL, category VARCHAR(255) NOT NULL, tag JSON DEFAULT NULL, description LONGTEXT DEFAULT NULL, main_image VARCHAR(255) DEFAULT NULL, user_id VARCHAR(300) NOT NULL, platform VARCHAR(255) DEFAULT NULL, special_link TINYINT(1) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE user_entity (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(250) NOT NULL, roles JSON NOT NULL, password VARCHAR(255) DEFAULT NULL, create_date DATE DEFAULT NULL, email VARCHAR(255) DEFAULT NULL, UNIQUE INDEX UNIQ_6B7A5F55A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE user_profile_entity (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, user_name VARCHAR(255) NOT NULL, location VARCHAR(255) DEFAULT NULL, story LONGTEXT DEFAULT NULL, image VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('DROP TABLE comment_entity');
        $this->addSql('DROP TABLE image_entity');
        $this->addSql('DROP TABLE interaction');
        $this->addSql('DROP TABLE report_entity');
        $this->addSql('DROP TABLE setting_entity');
        $this->addSql('DROP TABLE swap_entity');
        $this->addSql('DROP TABLE swap_item_entity');
        $this->addSql('DROP TABLE user_entity');
        $this->addSql('DROP TABLE user_profile_entity');
    }
}
