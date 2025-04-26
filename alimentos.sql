create database Alimentos;
use Alimentos;

create table Fornecedor (
	ID int primary key auto_increment,
    nome varchar(255) not null,
    taxa float not null default 0.00
);

create table Departamento(
	ID int primary key auto_increment,
    nome varchar(255) not null,
    desconto float not null default 0.00,
    ID_Fornecedor int not null,
    constraint fk_id_fornecedor -- ponteiro do relacionamento
		foreign key (ID_Fornecedor) -- coluna que será a chave estrangeira
        references Fornecedor(ID) -- Tabela(coluna) referenciada
        on update cascade -- o que acontece se atualizar fornecedor
        on delete restrict -- o que acontece se deletar o fornecedor
);

create table Produto (
	ID int primary key auto_increment,
    nome varchar(255) not null,
    id_departamento int not null,
    preco decimal(5,2) not null,
    quantidade int not null default 1,
    constraint fk_departamento
		foreign key(id_departamento)
        references Departamento (ID)
        on update cascade
        on delete restrict
);

insert into Fornecedor (nome, taxa) values
	('CEASA', 0.15),
    ('Friboi', 0.4);

select * from Fornecedor;

insert into Departamento (nome, desconto, id_fornecedor) values
	("Horti-fruti", 0, 1),
    ("Açougue",0,2);
    
select * from Departamento;

select d.ID, d.desconto, d.nome, f.nome
from Departamento d
inner join Fornecedor f
    on d.Id_fornecedor = f.ID;
    
insert into Produto (nome, preco, quantidade, id_departamento) values
	("Maça", 10, 1000, 1),
    ("Couve", 2.50, 50, 1),
    ("Coxa e Sobrecoxa", 17.5, 250, 2),
    ("Carne Muida", 28.0, 500, 2);

select * from Produto;

select p.nome, p.preco, p.quantidade,
		d.nome, d.desconto
from Produto p
inner join Departamento d
	on p.id_departamento = d.id;
   
-- Lucro por Departamento se vender todo o estoque
select p.nome,
	d.nome as Departamento,
 p.preco * p.quantidade * (1 - d.desconto) as Lucro		
from Produto p
inner join Departamento d
	on p.id_departamento = d.id;

-- Lucro por Departamento se vender todo o estoque considerando custos com Fornecedor

