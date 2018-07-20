Return-Path: <tyhicks@canonical.com>
References: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
	<1531497949-1766-7-git-send-email-tyhicks@canonical.com>
	<20180719143616.GA29715@mailbox.org>
From: Tyler Hicks <tyhicks@canonical.com>
Message-ID: <8f1d3ac3-136c-aaf4-ee99-5858c733eca9@canonical.com>
Date: Fri, 20 Jul 2018 16:58:40 -0500
MIME-Version: 1.0
In-Reply-To: <20180719143616.GA29715@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="pmZOc5s212o0USrQWaV5bkzsPG2zYgGqu"
Subject: Re: [Bridge] [PATCH net-next v2 6/7] net: Create reusable function
 for getting ownership info of sysfs inodes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Christian Brauner <christian@brauner.io>
Cc: bridge@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Containers <containers@lists.linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, netdev@vger.kernel.org, Tejun Heo <tj@kernel.org>, "David S. Miller" <davem@davemloft.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pmZOc5s212o0USrQWaV5bkzsPG2zYgGqu
Content-Type: multipart/mixed; boundary="nubycyRPPLVvL3uADqLNYwrhoCl2ivIUr";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: Christian Brauner <christian@brauner.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo
 <tj@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, netdev@vger.kernel.org,
 Linux Containers <containers@lists.linux-foundation.org>,
 bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <8f1d3ac3-136c-aaf4-ee99-5858c733eca9@canonical.com>
Subject: Re: [PATCH net-next v2 6/7] net: Create reusable function for getting
 ownership info of sysfs inodes
References: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
 <1531497949-1766-7-git-send-email-tyhicks@canonical.com>
 <20180719143616.GA29715@mailbox.org>
In-Reply-To: <20180719143616.GA29715@mailbox.org>

--nubycyRPPLVvL3uADqLNYwrhoCl2ivIUr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/19/2018 09:36 AM, Christian Brauner wrote:
> On Fri, Jul 13, 2018 at 04:05:48PM +0000, Tyler Hicks wrote:
>> Make net_ns_get_ownership() reusable by networking code outside of cor=
e.
>> This is useful, for example, to allow bridge related sysfs files to be=

>> owned by container root.
>>
>> Add a function comment since this is a potentially dangerous function =
to
>> use given the way that kobject_get_ownership() works by initializing u=
id
>> and gid before calling .get_ownership().
>>
>> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
>> ---
>>  include/net/net_namespace.h |  7 +++++++
>>  net/core/net-sysfs.c        | 15 ---------------
>>  net/core/net_namespace.c    | 25 +++++++++++++++++++++++++
>>  3 files changed, 32 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h=

>> index a71264d75d7f..a257710527ce 100644
>> --- a/include/net/net_namespace.h
>> +++ b/include/net/net_namespace.h
>> @@ -170,6 +170,8 @@ extern struct net init_net;
>>  struct net *copy_net_ns(unsigned long flags, struct user_namespace *u=
ser_ns,
>>  			struct net *old_net);
>> =20
>> +void net_ns_get_ownership(const struct net *net, kuid_t *uid, kgid_t =
*gid);
>> +
>>  void net_ns_barrier(void);
>>  #else /* CONFIG_NET_NS */
>>  #include <linux/sched.h>
>> @@ -182,6 +184,11 @@ static inline struct net *copy_net_ns(unsigned lo=
ng flags,
>>  	return old_net;
>>  }
>> =20
>> +static inline void net_ns_get_ownership(const struct net *net,
>> +					kuid_t *uid, kgid_t *gid)
>> +{
>> +}
>> +
>>  static inline void net_ns_barrier(void) {}
>>  #endif /* CONFIG_NET_NS */
>> =20
>> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
>> index 41d84c40fe51..a3ad8108d296 100644
>> --- a/net/core/net-sysfs.c
>> +++ b/net/core/net-sysfs.c
>> @@ -656,21 +656,6 @@ static const struct attribute_group wireless_grou=
p =3D {
>>  #define net_class_groups	NULL
>>  #endif /* CONFIG_SYSFS */
>> =20
>> -static void net_ns_get_ownership(const struct net *net,
>> -				 kuid_t *uid, kgid_t *gid)
>> -{
>> -	if (net) {
>> -		kuid_t ns_root_uid =3D make_kuid(net->user_ns, 0);
>> -		kgid_t ns_root_gid =3D make_kgid(net->user_ns, 0);
>> -
>> -		if (uid_valid(ns_root_uid))
>> -			*uid =3D ns_root_uid;
>> -
>> -		if (gid_valid(ns_root_gid))
>> -			*gid =3D ns_root_gid;
>> -	}
>> -}
>> -
>>  #ifdef CONFIG_SYSFS
>>  #define to_rx_queue_attr(_attr) \
>>  	container_of(_attr, struct rx_queue_attribute, attr)
>> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
>> index a11e03f920d3..5257875fa84d 100644
>> --- a/net/core/net_namespace.c
>> +++ b/net/core/net_namespace.c
>> @@ -448,6 +448,31 @@ struct net *copy_net_ns(unsigned long flags,
>>  	return net;
>>  }
>> =20
>> +/**
>> + * net_ns_get_ownership - get sysfs ownership data for @net
>> + * @net: network namespace in question (can be NULL)
>> + * @uid: kernel user ID for sysfs objects (must be GLOBAL_ROOT_UID)
>> + * @gid: kernel group ID for sysfs objects (must be GLOBAL_ROOT_GID)
>> + *
>> + * Returns the uid/gid pair of root in the user namespace associated =
with the
>> + * given network namespace. The caller must initialize @uid and @gid =
to
>> + * GLOBAL_ROOT_UID/GLOBAL_ROOT_GID before calling this function.
>=20
> If they must be so initialized why not just enforce this directly in th=
e
> function? This way callers can rely on always getting back the correct
> permissions and the comment can be removed as well.

I agree and made this change in v3 of the patch set that I just sent
out. Thanks for the suggestion!

Tyler

>=20
> Christian
>=20
>> + */
>> +void net_ns_get_ownership(const struct net *net, kuid_t *uid, kgid_t =
*gid)
>> +{
>> +	if (net) {
>> +		kuid_t ns_root_uid =3D make_kuid(net->user_ns, 0);
>> +		kgid_t ns_root_gid =3D make_kgid(net->user_ns, 0);
>> +
>> +		if (uid_valid(ns_root_uid))
>> +			*uid =3D ns_root_uid;
>> +
>> +		if (gid_valid(ns_root_gid))
>> +			*gid =3D ns_root_gid;
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(net_ns_get_ownership);
>> +
>>  static void unhash_nsid(struct net *net, struct net *last)
>>  {
>>  	struct net *tmp;
>> --=20
>> 2.7.4
>>
>> _______________________________________________
>> Containers mailing list
>> Containers@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/containers



--nubycyRPPLVvL3uADqLNYwrhoCl2ivIUr--

--pmZOc5s212o0USrQWaV5bkzsPG2zYgGqu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEPgU+cN5AsTrekT5+1pIAPaoCxwoFAltSWxAACgkQ1pIAPaoC
xwoOCQ/9Hwk8s0dL2KpCLqwdcs06QE0A9nw4ZsnjmzKvJN03QtWX84qTK+RTo0cF
Dq1gyS+MDBIUBwpRBYxg60pdyJszW2zAUUWfxiceAM/+10czY7PVdYKbbNLdr/Kj
K0FXWbAPgKZWZxSL3xOM+EcTgEY/oVU1FsNyTdtT32JuL6BsMBrOCNkMEZ5VIUSd
hSvhhO2idquMUDGB3O/MF9IZXVuCNn6DsYweMi04lz4zBuriOwB67F4ik4R4XKNp
+ZiiHCrEujy0vhqPu3ekMD13HNHaLFf5njcCqZ7teElq0zKE3mx+Oc/WX3Tx9F28
WKFPg/FDmCTsGYOfRBM2NOtkzwn6Ty0ZzmfHORjZ2JTuV3fuvzRTjzB11fg6+W5z
b7t0eSFrijJPk/UDUh4pKhHVxVwBgg0nk3QXfuFvFcdeBjChwWxNmqnbtHyr8+8Y
/vv7GZYCkj8OgaziQ0Ie0v6XVt/QcpDltCCL0O8H0l9X5+EwBC24RqKf0mTKTqJN
vwA7wu0MSfeitq1YD0e9Us2fDa0LuA0SmJnVlzoiuLHyqmtY11EGKmYlx6Ou5Ffl
WKlsssjdeQYbAg+ooUiRnSEIL7j23yQl+U/NCcqvB2gxmgStUmJsiflyDQ/IMsYH
vVF1EYLS54/Is7OBvgwApJX05I5LpDWU4v5o3SzIoL0ebeUxTk4=
=5BMd
-----END PGP SIGNATURE-----

--pmZOc5s212o0USrQWaV5bkzsPG2zYgGqu--
