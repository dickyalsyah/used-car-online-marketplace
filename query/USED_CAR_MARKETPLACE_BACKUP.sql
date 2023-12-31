PGDMP     .    +                {            used_car    15.4    15.4 5    C           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            D           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            E           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            F           1262    17718    used_car    DATABASE     j   CREATE DATABASE used_car WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE used_car;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            G           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            �            1259    17774    ads    TABLE     �  CREATE TABLE public.ads (
    ad_id integer NOT NULL,
    user_id integer NOT NULL,
    car_id integer NOT NULL,
    title character varying(225) NOT NULL,
    description text,
    mileage_km integer NOT NULL,
    color character varying(50) NOT NULL,
    transmission character varying(50) NOT NULL,
    price numeric NOT NULL,
    ad_status boolean DEFAULT true NOT NULL,
    negotiable boolean DEFAULT true NOT NULL,
    post_date date NOT NULL,
    CONSTRAINT ch_price CHECK ((price >= (0)::numeric))
);
    DROP TABLE public.ads;
       public         heap    postgres    false    4            �            1259    17773    ads_ad_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ads_ad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.ads_ad_id_seq;
       public          postgres    false    222    4            H           0    0    ads_ad_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.ads_ad_id_seq OWNED BY public.ads.ad_id;
          public          postgres    false    221            �            1259    17796    bids    TABLE       CREATE TABLE public.bids (
    bid_id integer NOT NULL,
    user_id integer NOT NULL,
    ad_id integer NOT NULL,
    bid_price numeric NOT NULL,
    bid_date date NOT NULL,
    bid_status character varying(20) DEFAULT 'Sent'::character varying NOT NULL
);
    DROP TABLE public.bids;
       public         heap    postgres    false    4            �            1259    17795    bids_bid_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bids_bid_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.bids_bid_id_seq;
       public          postgres    false    4    224            I           0    0    bids_bid_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.bids_bid_id_seq OWNED BY public.bids.bid_id;
          public          postgres    false    223            �            1259    17753 
   car_brands    TABLE     r   CREATE TABLE public.car_brands (
    brand_id integer NOT NULL,
    brand_name character varying(225) NOT NULL
);
    DROP TABLE public.car_brands;
       public         heap    postgres    false    4            �            1259    17752    car_brands_brand_id_seq    SEQUENCE     �   CREATE SEQUENCE public.car_brands_brand_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.car_brands_brand_id_seq;
       public          postgres    false    4    218            J           0    0    car_brands_brand_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.car_brands_brand_id_seq OWNED BY public.car_brands.brand_id;
          public          postgres    false    217            �            1259    17762    cars    TABLE       CREATE TABLE public.cars (
    car_id integer NOT NULL,
    brand_id integer NOT NULL,
    model character varying(225) NOT NULL,
    body_type character varying(50) NOT NULL,
    fuel_type character varying(50) NOT NULL,
    year_manufacture smallint NOT NULL
);
    DROP TABLE public.cars;
       public         heap    postgres    false    4            �            1259    17761    cars_car_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cars_car_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.cars_car_id_seq;
       public          postgres    false    4    220            K           0    0    cars_car_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.cars_car_id_seq OWNED BY public.cars.car_id;
          public          postgres    false    219            �            1259    17731    cities    TABLE     �   CREATE TABLE public.cities (
    city_id integer NOT NULL,
    city_name character varying(100) NOT NULL,
    latitude numeric(9,6) NOT NULL,
    longitude numeric(9,6) NOT NULL
);
    DROP TABLE public.cities;
       public         heap    postgres    false    4            �            1259    17739    users    TABLE     �   CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(100) NOT NULL,
    phone_number character varying(20) NOT NULL,
    city_id integer NOT NULL,
    zip_code smallint
);
    DROP TABLE public.users;
       public         heap    postgres    false    4            �            1259    17738    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          postgres    false    216    4            L           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    215            �           2604    17777 	   ads ad_id    DEFAULT     f   ALTER TABLE ONLY public.ads ALTER COLUMN ad_id SET DEFAULT nextval('public.ads_ad_id_seq'::regclass);
 8   ALTER TABLE public.ads ALTER COLUMN ad_id DROP DEFAULT;
       public          postgres    false    221    222    222            �           2604    17799    bids bid_id    DEFAULT     j   ALTER TABLE ONLY public.bids ALTER COLUMN bid_id SET DEFAULT nextval('public.bids_bid_id_seq'::regclass);
 :   ALTER TABLE public.bids ALTER COLUMN bid_id DROP DEFAULT;
       public          postgres    false    224    223    224            �           2604    17756    car_brands brand_id    DEFAULT     z   ALTER TABLE ONLY public.car_brands ALTER COLUMN brand_id SET DEFAULT nextval('public.car_brands_brand_id_seq'::regclass);
 B   ALTER TABLE public.car_brands ALTER COLUMN brand_id DROP DEFAULT;
       public          postgres    false    218    217    218            �           2604    17765    cars car_id    DEFAULT     j   ALTER TABLE ONLY public.cars ALTER COLUMN car_id SET DEFAULT nextval('public.cars_car_id_seq'::regclass);
 :   ALTER TABLE public.cars ALTER COLUMN car_id DROP DEFAULT;
       public          postgres    false    219    220    220            �           2604    17742    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    216    215    216            >          0    17774    ads 
   TABLE DATA           �   COPY public.ads (ad_id, user_id, car_id, title, description, mileage_km, color, transmission, price, ad_status, negotiable, post_date) FROM stdin;
    public          postgres    false    222   �;       @          0    17796    bids 
   TABLE DATA           W   COPY public.bids (bid_id, user_id, ad_id, bid_price, bid_date, bid_status) FROM stdin;
    public          postgres    false    224   TX       :          0    17753 
   car_brands 
   TABLE DATA           :   COPY public.car_brands (brand_id, brand_name) FROM stdin;
    public          postgres    false    218   =g       <          0    17762    cars 
   TABLE DATA           _   COPY public.cars (car_id, brand_id, model, body_type, fuel_type, year_manufacture) FROM stdin;
    public          postgres    false    220   �g       6          0    17731    cities 
   TABLE DATA           I   COPY public.cities (city_id, city_name, latitude, longitude) FROM stdin;
    public          postgres    false    214   ~i       8          0    17739    users 
   TABLE DATA           O   COPY public.users (user_id, name, phone_number, city_id, zip_code) FROM stdin;
    public          postgres    false    216   �j       M           0    0    ads_ad_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.ads_ad_id_seq', 1, false);
          public          postgres    false    221            N           0    0    bids_bid_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.bids_bid_id_seq', 1, false);
          public          postgres    false    223            O           0    0    car_brands_brand_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.car_brands_brand_id_seq', 1, false);
          public          postgres    false    217            P           0    0    cars_car_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.cars_car_id_seq', 1, false);
          public          postgres    false    219            Q           0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);
          public          postgres    false    215            �           2606    17784    ads ads_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_pkey PRIMARY KEY (ad_id);
 6   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_pkey;
       public            postgres    false    222            �           2606    17804    bids bids_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT bids_pkey PRIMARY KEY (bid_id);
 8   ALTER TABLE ONLY public.bids DROP CONSTRAINT bids_pkey;
       public            postgres    false    224            �           2606    17758    car_brands car_brands_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.car_brands
    ADD CONSTRAINT car_brands_pkey PRIMARY KEY (brand_id);
 D   ALTER TABLE ONLY public.car_brands DROP CONSTRAINT car_brands_pkey;
       public            postgres    false    218            �           2606    17767    cars cars_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (car_id);
 8   ALTER TABLE ONLY public.cars DROP CONSTRAINT cars_pkey;
       public            postgres    false    220            �           2606    17735    cities cities_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (city_id);
 <   ALTER TABLE ONLY public.cities DROP CONSTRAINT cities_pkey;
       public            postgres    false    214            �           2606    17845    cities uc_latlong 
   CONSTRAINT     [   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT uc_latlong UNIQUE (latitude, longitude);
 ;   ALTER TABLE ONLY public.cities DROP CONSTRAINT uc_latlong;
       public            postgres    false    214    214            �           2606    17760    car_brands ucb_brand_name 
   CONSTRAINT     Z   ALTER TABLE ONLY public.car_brands
    ADD CONSTRAINT ucb_brand_name UNIQUE (brand_name);
 C   ALTER TABLE ONLY public.car_brands DROP CONSTRAINT ucb_brand_name;
       public            postgres    false    218            �           2606    17746    users us_phone_number 
   CONSTRAINT     X   ALTER TABLE ONLY public.users
    ADD CONSTRAINT us_phone_number UNIQUE (phone_number);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT us_phone_number;
       public            postgres    false    216            �           2606    17744    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    216            �           2606    17810    bids fk_ad_id    FK CONSTRAINT     k   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT fk_ad_id FOREIGN KEY (ad_id) REFERENCES public.ads(ad_id);
 7   ALTER TABLE ONLY public.bids DROP CONSTRAINT fk_ad_id;
       public          postgres    false    224    3487    222            �           2606    17768    cars fk_brand_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.cars
    ADD CONSTRAINT fk_brand_id FOREIGN KEY (brand_id) REFERENCES public.car_brands(brand_id) ON DELETE RESTRICT;
 :   ALTER TABLE ONLY public.cars DROP CONSTRAINT fk_brand_id;
       public          postgres    false    220    218    3481            �           2606    17790    ads fk_car_id    FK CONSTRAINT     n   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT fk_car_id FOREIGN KEY (car_id) REFERENCES public.cars(car_id);
 7   ALTER TABLE ONLY public.ads DROP CONSTRAINT fk_car_id;
       public          postgres    false    220    222    3485            �           2606    17747    users fk_city_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_city_id FOREIGN KEY (city_id) REFERENCES public.cities(city_id) ON DELETE RESTRICT;
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT fk_city_id;
       public          postgres    false    3473    216    214            �           2606    17785    ads fk_user_id    FK CONSTRAINT     r   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 8   ALTER TABLE ONLY public.ads DROP CONSTRAINT fk_user_id;
       public          postgres    false    222    216    3479            �           2606    17805    bids fk_user_id    FK CONSTRAINT     s   ALTER TABLE ONLY public.bids
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 9   ALTER TABLE ONLY public.bids DROP CONSTRAINT fk_user_id;
       public          postgres    false    224    3479    216            >      x��]M�$�q=�~��f�H|�FҴ))H)Dڲ�4����yv��w&��S�BPۥ�w�����H����N	#�?�T/���|��������|��o����n��/�z�����������{������������˻ǻ?NO,��ỻ���7^������?޽��y�������²����w�������xݟw����o�{�z���������?�q�J��K^�G�%"=L�e�B%�x���n��U���&��t�����?�o~��~��t��7��rw��{���N�Tu�}m�.h����/<���?�����jچख़�tZ"��ċ����g�����B� ��|�������O��XE��y�jM�p��?�?>߼{.}d=EW�v��=���|����n�������>
��z���6���I�Q�J�*��ȞXV>�(���3�{\ɦ�m��M� ���bXXO�{�<�RK7!I�]��j�B��;�f���_w�vO�o>���n%��9��K/e�����/|s�d����R">>���z�fD�D2@�d�?|ڿ�]�ҧ�i�`��6�@�p�3{�KƦ^��x���Tw��s���r��/�4(���Ӟ�}Ф��<I����K�-o���b?���M������1@i�絟�D�%���B�ݳR݂�@
�'�p��e���&�]��}�9����z�'��&6�l]��SRh�?j��\��Y�qZ���]�w�����D)����$L���#����ç��w��F酗م菿�=?�n�v-�u��8����KI_I�o�%2y������/�|��7]E���I�_t�S��=�	[xK���K�+߿g��yk�b5{7p�._��L�����=G7w�8��N�ॗ44�v��D�q`/�X�(%z/�s8��bj(����SF����PGg�w������/kۀ�G�d걔�ʛ��l�:�R=7��{���&�ґ3fS���셽ͦ@���ʧ�2,>�IJ��R��eg��n!t�"Y$'4�߾��p��[��/��U�8�|@���D||�|�L+�.V28��R��㟔��'�SP�d��j��|�8-�3}��3��z�����)C�3���oQw�m����}��%���טut���Q�p����zxn�
�^�U+�`��e\r0�xɐnC�hi٠��~��_\��>�����:ߍ>��m����ݛ��J�
-�^�:I������1p��z���d��g�şn��V�_w)�^w)Q�t^R��Z��B�t ��4���셧khy� �|���w����1v���K?*ӯ���gQ*�nP���l���P��"���z�%ǪG�t�$�a�[aFx'�x]���o��kEF��az���J � �Wr�OR%L�r�͓_x+Ɋ��.��*�].@]�طV����L�*�wc��S��u�C��o������盧�Z�=XX��MR���<9�7�į���,���~\��U�hك�~|��K�1�cIJ���G�)�U���x��1��w������	��ֶ}(X���;�*K��Mz�K;��&�����瀃@Ǿ��:W����������ˬu�v���D�<��s�����vt��cx4�WoaV����#8:����+
�Fm�6~�OJ����.WiZ1+���8c�|&-�gL�C���S���&�i.�F䓷�a���EO��k���=3�%�]�!o��Oh�N��V�b-	/��e��)�իe'm���2:m���0ׄX*VG�Hi+Y����A%��K�і�F�q��G`Je���I����N�Em���#I[�0N�}�9���b���lz�*��4��R)m���q
@�c��k)���~�ڽ�?��y���')��P�˱���N{�I�SS��\��������4 �f�����P��T��8�ǥ�>����
սƛה��b����q�oj�U��nD#G��8�r7�z���D��)�u˝�(�����:�V� tg�n���Ro�찶�~q�>I��$���ˤ�`e@O�1�W�l�����綀7�q��k-�A�>@a�{
OK��ōr�R(`4'��m�ɷϷ�Js��X�@V;0IJ^�a��+�W������l��>fb�{��c���?�֔�����+D��y�@j��$�J��%�?�GK�f�k�ޛ`>�ƍR��>b�D�;=��6&B��U��ÍEY�6�%�ڷ1�����'�	����4�@�]��B��@v)���1y6v��G��ay�H�*:=���-��01Vp,��q��Z'g
I���΃F]�t��h����|�O���@���/���������_��E���d�ɐ���or��Y�#6�U��.�d�K����P[�I�BDC�c���\�R�wp�˯��`y�Z���^��s:(�?ȁ/yD�m.
h�Cy�/�AI���9@/aa��ϵ���6�T��\S���%	~�S6�t��{c�Qп��TU����\|ȣԸ�A-�c��Z��(�+�qW�o����yE��H�~�3�t�E��za��|�&�s-yc�ޑ���ʸd�`lķ���,虻l��c3�D�Z��]Ӓ�NX�:�ySr��:M��_Fm'r>t
Ҙ�<QjȴB;�ܠ��0̈́��|�)ƾ�Q��I�(U��ԀY�L@gY�S ���_@��*\��ORc���\��^���"�D�%�-@�:-��h
b��S�k�r��j�;�4��a�����*xZ2�Pj��32�"��6ߖ�^UtPʔ�/��3.+��Igs�EF�g��M�fNs��ޖ�f=M�%=���a �v�v��h-�������Րx��U�վtKdw�U�=�ݝ,%��t��V�c���	q�A����,E�E-.)�^���,@�(�� ���U	:��g߮�%��b更��!�<ڨY\��ftυ�5�PP������,��K�a�Q��I��6��т0p@n�rPw�*#�>g|fȍ�ȡ$�䩺}8��=�=��)h���n�s��-s\�T���1�?��64�йXQ;��^qE���o�.(������(� _&Q��l�㳹r�3n�yORsV���S�M��p�}slBՠ���Z�,�(�������\�Vz�S�j�+D��(JIN&.�k��8�R�b�886���x��6m�a����~�t� Z=Y���z�t��ubc֘�P��!��g�a�	�ʦr���՝����M�\%X�+P���@���>i��Cc�)��u����Y� �c �T2�}�F����Ʉ�Sc�ieε��p�(���ԑ�g字F�H�����F�M��W.[�%Λ�f�%E:>���#XɃ��@v�d��o�o�0���
�#J��Ѫ,AC�_��kN� � �����_�n�DO�{����z݀y���1K�ҝ7��uK���Y܆�
���k؛�"vLN�1�~c�ʪ�� QhL�6�;ЇYQ>RBm���J��W���%�Po��r�X��y���h8����I-lk�ɌRhv�eÿ�`0������̀�#�5�P��HK���Iv�p�ɢ�ߐ�bY�*���d�*@�}���xH��:V���WÂ{����	^����5�_�^�w��}�5�������^����C�� �ց�m�Փ�/O '�	�^����� A��o��F���R�Տ~�"/7�XV�d肉U�-B�Z���s��'f�Ԅc��
h�&��Y��}����f>��L��6FW+�+��o��iZ�wV��Nմ�?�"�_�>��U�����A�=/�QCG:���|Ij�B8H��h�#Bt������ǯ0�iD�rҖz���M\21��m��"m�%bZ0�tEV��Ғ1&����XOwdt����p4ߩ�F��#Ӓ���z3�h�ޕp�;��惿�WJ��9��}��c�z&([��KK�M�6X;P��CѭK.�6 �  ����oe-.�_$��Et��|�Gu�:fĶ��P?R��3$�Q�L9f��릎�%%��m~-\Ό�p���$u�r�i��Rj���� +[q�[w��X���]
!zzOK��]�U��hFs(i�MJ�Խ�✴5L��
K���Ӓ��ђ9%�d��t�&q�m��1+�<-)f;84}�$)w�+�In�w�z��t�4.�P���g�7��Z�\���sK����2�+#�Ғ�\��/	��t�
'�����1��&[u��-1�UreQjj;��0�
�@7�R�s,旺k��0_ob#�EY�b���-�L"=�lq�E�K�	:���Ijإc�$i�����9�9�t|���ڎW��<��e�L��χ!ot���	\�����3�Ԉ>�'6�a}���jiy�${]8�u��l�a�ƓT�/9([5@N�SQ�2${���-pA!,Ʈ&��'Z7��©|�p���ki([i����$Uڋ�������Za�=����K��4(��	-jN�`�î��ܢ>m��M�7��Z��e�g��ة7�
�J�5�K��!��LE6bh���꿂�Dg���(�Zg�ϥHR�(�����z�\\�X̐w��&�5��W0<�y�`t%���L��"�<s,r�m�wo��wX��t�є
��� �x:����OM#W
�<7���D)���`*I�z��t��ֈ��9�\A� 'hc۱��qq>3JM������gZ�dj���i�%��!V����*���.Xr��
όC���WUV�[e�X�1��;Q�@����J��a.�G���m2�cZɮIk�ë�$�!Ӂ��B��0�d�G�*S����5���.��D�^�O��Co����d���L��W�}~M��\C��&�{�qI!���2�ۈ�ђ�-nLխ#�Tpr�י�&Y�U8� �Ʈ�]��`z�-�wڧv�"Mt_�q�L͐�Q���H�nY�6y��!<��� ���l��:m���B�B��!2���!T������;�/����SP�M����3�Z�G�REzm��B�Gמ�|���nF������I���MZr���fz��ȹ62��o��2��J��B.IF�ɠ��F�#B��U���W
<�ȲeN�W��fߟ�%E�)c��z�|�Ӽ���\�d|��"-)RU8t:��C�8w<KH���lf�O.&hIRc7�,a����lm6�J���:@XN�����n����|�����Ο �-o��ܡ�!�p��H�'k��Q$�,Zp�4w�r���8�f4�c0R�<����l+\qޥ��{�q�D�J��y�\At�Fj��¢�m�oā���ClK��9*��}�Tj?q�	�	�B] oJ]o=-�%=�~s�s@�KF���rz��/ժ7�5Na�O��e�̀#{����nq�z���9]��G�1
*(��K�E;�9o95��ZK�M��G���Jm�}���yj=�BF���٧�5�B�a����Z Cd*\PiI��׋X�����^�	:��k~�,n�a�>a9z��@�$;;J����*�[�GTc�,S�w��jxI�SV� �箻��4q���*�Aέw7d�Q)(�G�Z�Yj��w
� t �.��|mg�+[����<rJR'n���5���	���{��m���+�����]e�ӿ���D��8�\3h��V����x�~��-Ƌ3,4�tB0����<��ȔP��}����{��ԡ�!?�p@F��E����2�����p�*����������V�_+�S;�DCx_\RT�v�)w=sz+�]B�x�_��?�TKN�G�VP7iI�͐�� ��h)l��5��:�1����Ըn�6.�4�Q� �����7un����`e����촤<�D9�x���\�����&���������Ԙo�X�:����<�w�a�2�ʵ�W�T~y�,I��������5�ʽg�1�2�l�b�>IM�R�Ufx時Ѣ��@u��Z�Ο�ۘ:� �4&��	D�)fM���C��6�
��*U���]!_T�G�̛{�����,�LS�]^��\smV����!Q(�ӆ-��`V�=d�(vZ����us��X��;��m�0O��
K��(\-���ZJX*o�k@i���8mtk�Swϕ��3;uZ(c�Ŷ'I�h�����:b������6\��.���T9�#�Z��<N�d�I��+�y�Z*Y4�y�BZR*[�L�@*�Ȏ���m.�S�u-�j5r��cK�n/���K�ߺ���>l�٤yP! :��3IM*$�퀘c��3<B�S�À�r۱�	��$skHl��M�K��)�� g�d+�td��$��*�+.�ե�a�p �%p� a8�#��K�M"֪�\��W�(�%#R: ����d��l���N�M�m6.�����!`U�����YC�
)�1��%%�h㽶���)<��^ֹҲ��􏥊��L�=c#	���m���5��ҷ�w^⒉{�9/�pjC/��Yb����^nڸ����Y��E��KL+�8.�ةyM�k�B�[���\�T!�`5ˆ��由1�j��yI��ȇ\iv��.h>�P=I��.%�7�%x�'���r���h�Wi� z99N�*��q^��r�����'�����}���yxZR�i���:K�ޒߺ��A��od�����~P�p��sc�w�Xe� 5�s��Mη�!,/RE�+�A���k�AR����-�l���t��6-�S���Q�Rf����Ij(�ҡ��rҒCM6�k��2d��0�!H�K��a=u]�r�4/K"�q�=���v1�R͵�����J��i��/�,��q�M�r�ۑ�9n
 �d��������?~�ڛyN��d<�K�ӘǗ�|�Z	tc�2"\mnl�4e_��ƕ��� )J��r�g�e������������.N$�r����H�wb����p�+��̃���n@�C鋫!-Yj��`@�4�����6[�詣m���g>XMKFК$��u�Xm���o�3��}�����bÒ�?}��n]�Ӑ����ۓ��UBg΅1�Bg<�1�A����h�6g�<0��������hd�C�zޟOKzl~�ɗ`͠O�T�:����׼�@��j��\Ӓ5t���s����/]��?���      @   �  x�uZˮd�\���	$J�c���Ƌ,'���*��U��g`���*�ԧ������>���X�����Ҟ���ן���߿���u<u+��W������?��_�Y����9���^����UV�ǰʟUǞ��j�];��_��˟Y�:p5+}�ϵ
v���xfý�|���Z���g`�|��e�.­�s�z�^a�>�ݫ��c�~`�n�c��rZ+�N��;.�z�z��ϭp�W����}��v����_V{����w�rh{�/�t+?]��r��V��l�*F{��^�L�g�gڶZ_4���;���N%�ap7C�Þ�۸�/��e��l�� ��u�!���4z����~6[j[�Dn�����l�w3{b�c�f���e�}��'l��R��{d�U�よ���	ܽ�rCR�쥫CO��kI��]4#�qnŉ��H��]��9� [u��Q�����)�9��U��*L�����L���[e섋l��]����=W �1����#߸�������H�z1���J��%$4�?�<"��ڦ����k�x^X b�SO4��` �^�f�g�kU�/�w[��7�[ fE�UnV�Tl-����X{�w�{-�/�h���c�t�<|���~�]�����a���RR:B��`V���R��@�?Ǯeh�(��AW\O�Ϻ���� 97�z��d���D�$lku�� ;�b����XR�p#X�ϹfB���h����ްqc4�JV��R5����U$�-Cl��V���:@�M�F%]����n &�5S��  v�nE�����3�Q2�Ӟ,v�W�P����
	V��B0W٩����m�,�O6��o�X
D��E���}��p�!�
�Y��%���>�W��H�#�ܺ��,����r��u������:���I�ʐgR^�W�yg�ʞ�I�עtohH����c?Nt̞�I��!B��^���23�9� osJ�)��D���=k�E�B��І������\i��`� m	�%�A�����]�#���o��nz(� r�R(�M���{T]�7%����*��E`읪�u�"�D92��`��d�)d9<D��n��v�2݁.�Y�k�F��O��Zz��� ԇ��d��T$1�Ǒ-�Q�3/��{�x�*�S�<����f�n,����C;����RG����B�%�S.n�B����1�4-���S)'�|�j[�I۞��o�w#��T��1l���V��A8YZ��YM��޴�i@��-���C�X�>������-� ��l�ÿ��Y�H�z/�����b�$���B�|�/m���N��fZ6�*�)@��T��#p,�J�;Vb��yɵ���>EF��ud�a��D�W��}F��C꿿���pĎ  �*S�MBt�	�٨߰���"�H���o�^����;�Əܷ��F�AФ�݂@�DUiX��$5k$Ce�C���zᳰ�v�x��nhK �� k#��j���A'�@�6k7�{��C�6�s$G�_H����óQMan������e��1R��n���Zx����e��7��=��r���U��	;rt�ň�͞��CjVR�!TJ4B�Mܢ����!׼q�L�*�f&���{���r�r����vZ-xz%
�`�HTQ�h�J0�M�	�d���Aedv'>E�Ų�[�oZ��R�3���(5�ٕ��ѷ��k�g��Q�!Wm%Z/t��Q_a�g�^�.��r����Hr��ըp�d�
��3� Q�i�ke.B�H8(W 鱛y�"� �)�ĭ(L|(�k_NU��
+���.�"� ��L�P�[R���+"�����M��%Z)��g� æ:�t��)��!��y7�݀H���rIW�Q���
Pw��MR�3��K�ǫ9�p��^�agm�T��,�!��~���vdhf�p]�|�*��(_xr঍(]��-�g�SU�/D|�۟�=��v�3��0������C���$$Rj�
C;� ��S�+���"�B�̞
�$6C�3Ca�<d�b9>`�������p��
Zkϙلb� ��O0dj�	)<��O�:Gr�v�$! ��,H`Df����$#��"@X��Yo�%��.:�P�*KCY��c��ZK�˗�5��&���ڍ�����ӄx�Fr��1j{�ʵB*�ݻ������c/S��$,�q(dU��$ˤCQ�W�,�*�t�G�yFaA�iy�
���y�x.h�U]�oDU��{����Q�<�1�)*�e����a�(����~FH�NV�vz*���'��Wu)<�!�!�VI�1Aފ撳7�WM@+��E��+h��_���џA��I�C�t�%p�)\A��H}휆��=���Ŷ����i*�hF��Xk�(���^��n�DkF�e֭�FI���������lh��n;�k�(3W�<;�B䖠�[���\�8���j�G�OA�\`Y
bu,�MCV<��طE&��PK}���Ǯ3�3ĉ����j�r,���#M5R{#Xl�2�d$�Z�d���m3��桱E���,KL�4_!#b�lj�i� ߜ�]]'�l��`��v�l��3�UY6�E����n7�$1�t��Ex��Nf��l�(���Gd'#:��M�]PD ��`F{�/�(Q��a`�x���$�T�b�5���[�5]מW��Z�i� ���Տ��v�2k5�&z.lњ�t�Ob/�\��R�w�y�7�����M�K ������F�i������QS��1��}-)P�������u2�d�_���iZ�{K�D|s	���HFOF�QN#���R�-@'
<�Ԭy�Te]����{?u.cà#����Q
<d�c`e�ǧ"�1��X	��/�L�w��^{�3���'2���XI!�I�C	�Z+��ת.��)T+2�X�'n�%/���+���zؘȂ7����@�G	BF1��l� �J�]���kk1e�����	����n�OD�տ� ]�g�������LX�AL�o����'��������������Z#V��[�g�N��@�{���Gs����w�q��f��j�����i���*O�ء���F�K���^r�X≢;�36�1N�Ȉ�':�X叟��BD ����,U�
5�:����,5%<:� \�\McEw?��h���Kk��-n��.j\�S�|� ��ӝV{�I����"���Jޫ�ǲ<��o�L�����fMf �Hp��L��HW#8���(	%P�팀��@;��v2�q�k�[�怷hS�I�&���>_������>�I K;yV�H"n�G�CS���׃�[���R����� �i-�����z20�2��:<)<Y��[3�,���|�D�m����;*�N^�YѮ@9��e�l�˾��}���^=}6��2GL�g#dVK�b0�6��ѓٞQX�=�� Aa��4~Mi�羬Qh�׌��ߒ�e���u�(}���L.q�7LY�A�L>W��rA䚓���8��pJ�}�bK)�[�zߧ/��&ߑE[n=W$��m�aJ���0��Z��' k���ogK���N_��h3�ϼ*�Z�γk|�0�[��T �г2OH�O�c�:�@�O 
�����S(��Ԫ �o�8RE�ȓ-��q��-T)g�"�J��H����W��62ζ�7 �{��d����K�+R�e�^������ׯ_����      :   A   x�3�ɯ�/I�2����KI�2�.�*���2�tI��H,).�2�t��2���,*������ �.0      <   �  x��T�n�0<�~�~�����c�4p�(��I�^X��	T�G��K�h)K���fggg� ��?��|j:�S��um[c���#�V��n�IJe;�<h(�����VWgP���<�ia������.���k��N]�Q�8�+�W]�'/�1u;�U`�%1
��a���t��M=(��K}�]����
^ծ�C�Nf�h��x��ݏI$�kY�J���f�Ă�����h*��w���^�dh�cmͯD�_L�5���1�_��f�ު�c	O�	c)��E1Wϑ���8	�l�H�����rwn%�{=w�Ͻj���2�b6 �ڲ�Krb�����s]�6r3�s�-)݁�v�D����X]>#1�=�:a�Lb���G��w�p^�S�M�]by@�@&Iw,Ő�M[�&��i�&G>�=\�9�ϱp?����,�S��Ǟ:C."�� �|�z�����_�Qɘ,dȋ�{(Ҩ�K��GD�UB�      6   b  x�U��j�0����G3��aO[�����̒LR78�!oߑ���	��ͧ�3v�ߓ��cG��6_l�^4b�T�C�X8A����L6ڂ	˂sNH�a~��k2���KrzƻϓM64� ��ƽ�4.�����ǆIS��R��{���l8t/9ւ�����
pSeU�y��v��TT]\�ĵN����>\��M暉Z"D����}�Ɔ��k��rr9*x���7�/� VX�a� ���ě��OS?}��VDW�^6}4�ة?���ֈ�Ϫ��7C�n�v�;�����";���_O~t���/�U�_c���1��|�<��ߟ��W��R�ӠD"�ZÿB�Ot�)      8   <
  x�]X�n�\7���1���c�;��81lg�t%�R�h�cx�~�t���&d�<�TՑl��j����������!�8�A�V����mdN3�\�m^���*u�]��qe�	W�qc�-���f���V�k�ǟ�O~;���6��n������FZ%,3�i��������>�n��ָqA�*gm�W���m��m��yz��?��l�H	xD��:HOI:ns͇�-^��t��t��Z�W+�nmt�і�	2:曋~�?�.=g�_�~X {z�c귍.
c������R��\��~��i�pFq��J�R#�`��+�6�>�?�U�Q�Nn���E����I���۴�Hs���>F���^�]1rim�kx�:ᙔH %L�v�_�a;���n�l�����E&Us�z���&u��a�S�Գ��b���UQ�������0��/�[����kZce�׵@(���xL�w �a<��6#Z�F7~�*똴 >'\����ߦ�>�C0B�7�s����B����&����}��z�9@t�����sZ%:�M�ԇ��B���*j_�f��L��f6���*u��I��l�t8��(dȂ%D�ũ���Zz��b���/â�g��-�aQ1hddJ4��/���Q�	��*Zk��	�.�� ɻ�+w�e�o�z�{�7V��=�"�(U7�:�Ts����͒����%M��׷�*����Jɔn�M�U�F]\���9x���1���Cꩧ7��E�\dk�L�(-�c�,h$C�����@aR��\G�\�=�knR^�_�?C���R ��5�E"��eH�*��{���O�E3��T�:eM���S�9cx;Qʠ����KU�����|{BsB��!M�t>CY"�F�hd��~ZPY6�PE�h���W8���<㙖�y&�bTw"����[da���d��{�Q'Q��g��i*�k���CTu*���1���+nJ]�"�Q\j�d�K�-f����J��!?W ��4�M�2�18�k�O���4ݻK��j�8���Z�$�r�ڧ��!JxH/����5wZc ՔR� M��?���v�5=ŁM��|`,*�]�ާ�P@lњH���:67;0uǿ}�]�n%΋�j�*�zz3��<��[��龚]/jP�R�M��y������`�8��5k	�M=m t�vUl��x$ɃL�H��<��Y��CzScҳ��ޫz�c�t�f��a��}�� 8P������m��VÞ^x�t���!P��Df�Ȅ��J �w�Qk�����(�hCx�~E������q��0U Jc$�'�jx<�	�|�-���)%��h��q��X�E�A(w����i��m��}w�
͝��Fi�6x!O�Y�!51P\DSm��2+��Q�q�a	�"!uƵП��7T��� �� )���iϬ�����|�;�nEz+Fus�I0$��v��̻ѷM�8Z�M+�4F��`�Nw���ϻ�	� ���x#f]s���^a,��G���1�ʢn�[�Pv��{���U�p
X�j�:lAiN���Z�V�^�ǧp�L|E(�j��EV�Q���VV�lc�̉���>��.&�q�#�d,]���ds�q!Q|@��%i�-X��Yа�j��� �%���R��G��C�Tu^ O��ԧO������zd����#$Zo��T�)�D�:��	�x6��
�ڡhʗ�{�t.	�vϻWZ�g<��l�H�&��`��?A��[�������F��WXN�������9@���(��K3�O��G�w�wD�dC�q�h�,�-"/�6��&_K��h(�n0����k��?�~{�_��$��qDd�v�"r��/���9�NL6�×rE������Ʋ�k���������9f_Vg&0h�c>�`~��I��RH\܂ډz�������gL�M��L
j+B��Ő�%N�+>'H�4J�8�t$�Z��e�t��ݸ[}��ŅT��5>�$g[�a��a ��%���yWLP�\f!Ӵ������t=��[���\X쮦��
��g�O��b��$�%�D�uկ(1��z��ߪ�=���\C%�D����|��.���8a++��䳠���m^����<�����k���8��o���5��F�1��c|�1c�<h��q�8@*k�rp!�%�F�D��`������d��Wز�m}oP�e�aK�2����v*۴8�2�Dc�
0���p��m�AD���bY*��,�iOǅ	V�\�!�c���ܕ��E0n��]u�[9�c+�:aˇ���6E��3�C�*�E7$�m�8� 6
�ۂv��X���s����B Nb�P;,�Gv%�jq��G_��В��C�P��YƊ��D�����~�XE�T0��h��XOw��&΅�!��g�I��(�(���'��U�Y:�0(�������hC��IdZ1zЃ���a$�&]�g����\E_x�;(���?�&����_��F:�NT���J��)��`ǎMⷮ�G�ѥ� \]�4��ߌ1�/!��<     