Return-Path: <santoshprasadnayak@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:content-transfer-encoding;
	bh=Y81awVCb5G6JjZjTfGkTvyA45mT2VvnD47V9t6JFADY=;
	b=S1P78wO7+Utut/4mpDBzZ4hJc1BjBYmjMjAqH47X1HOFWf3lWJpu2YzBRf72lAXBCx
	JfDWvQ+OyDlfsaut3ScC6GvQVESNNfqYV+3DIcfsR09GgI3DPdcPxuzGgNp54vSQzzk1
	It6U48YWmP2qq4d+8hJsppwHgPhaJEGeWAANI=
MIME-Version: 1.0
In-Reply-To: <20120301101809.GA6488@1984>
References: <1330593390-19233-1-git-send-email-santoshprasadnayak@gmail.com>
	<20120301101809.GA6488@1984>
Date: Thu, 1 Mar 2012 16:15:05 +0530
Message-ID: <CAOD=uF6yqCETUG8jMCmjYDM+L1DsM91OiRveONJkNxMf=skTSg@mail.gmail.com>
From: santosh prasad nayak <santoshprasadnayak@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH 1/3] netfilter: Fix copy_to_user too small size
	parametre.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, bart.de.schuymer@pandora.be, netfilter-devel@vger.kernel.org, shemminger@vyatta.com

Hi Pablo.

copy_to_user( dest, source, length)

Normally,  'length'  is equal to  'sizeof (source) '.

In this case "length"   =3D   32
       "sizeof(source)"  =3D   29.

Is it intentional ?
Won't it copy extra 3 bytes of kernel data to userspace ?



regards
santosh



On Thu, Mar 1, 2012 at 3:48 PM, Pablo Neira Ayuso <pablo@netfilter.org> wro=
te:
> On Thu, Mar 01, 2012 at 02:46:30PM +0530, santosh nayak wrote:
>> From: Santosh Nayak <santoshprasadnayak@gmail.com>
>>
>> While copying to userspace, the size of source is 29byte where as
>> size parametre is 32 byte. =A0Its leaking extra-information from
>> kernel space to user space.
>> Replace EBT_FUNCTION_MAXNAMELEN by XT_EXTENSION_MAXNAMELEN.
>
> There's no information leak.
>
> Let me clarify this. Have a look at /linux/netfilter/x_tables.h, then
> you find:
>
> #define XT_FUNCTION_MAXNAMELEN 30
> #define XT_EXTENSION_MAXNAMELEN 29
> #define XT_TABLE_MAXNAMELEN 32
>
> For iptables, everything has been 30 bytes, but we stole one
> byte to store the revision field for matches/targets.
>
> For ebtables, there's no revision field and the length of the
> table name is different.
>
> But linux/netfilter/in ebtables.h, you'll find:
>
> #define EBT_TABLE_MAXNAMELEN 32
> #define EBT_CHAIN_MAXNAMELEN EBT_TABLE_MAXNAMELEN
> #define EBT_FUNCTION_MAXNAMELEN EBT_TABLE_MAXNAMELEN
>
> Note that someone decided to use 32 bytes for the ebtables
> tables/match/target name instead of 30 bytes in iptables.
>
> Yes, it sucks a bit we have to live with these interfaces until
> we have some netlink interface for all these things.
>
>> Signed-off-by: Santosh Nayak <santoshprasadnayak@gmail.com>
>> ---
>> =A0net/bridge/netfilter/ebtables.c | =A0 =A06 +++---
>> =A01 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebta=
bles.c
>> index 5864cc4..f3fcbd9 100644
>> --- a/net/bridge/netfilter/ebtables.c
>> +++ b/net/bridge/netfilter/ebtables.c
>> @@ -1335,7 +1335,7 @@ static inline int ebt_make_matchname(const struct =
ebt_entry_match *m,
>> =A0 =A0 =A0const char *base, char __user *ubase)
>> =A0{
>> =A0 =A0 =A0 char __user *hlp =3D ubase + ((char *)m - base);
>> - =A0 =A0 if (copy_to_user(hlp, m->u.match->name, EBT_FUNCTION_MAXNAMELE=
N))
>> + =A0 =A0 if (copy_to_user(hlp, m->u.match->name, XT_EXTENSION_MAXNAMELE=
N))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> =A0 =A0 =A0 return 0;
>> =A0}
>> @@ -1344,7 +1344,7 @@ static inline int ebt_make_watchername(const struc=
t ebt_entry_watcher *w,
>> =A0 =A0 =A0const char *base, char __user *ubase)
>> =A0{
>> =A0 =A0 =A0 char __user *hlp =3D ubase + ((char *)w - base);
>> - =A0 =A0 if (copy_to_user(hlp , w->u.watcher->name, EBT_FUNCTION_MAXNAM=
ELEN))
>> + =A0 =A0 if (copy_to_user(hlp , w->u.watcher->name, XT_EXTENSION_MAXNAM=
ELEN))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> =A0 =A0 =A0 return 0;
>> =A0}
>> @@ -1368,7 +1368,7 @@ ebt_make_names(struct ebt_entry *e, const char *ba=
se, char __user *ubase)
>> =A0 =A0 =A0 ret =3D EBT_WATCHER_ITERATE(e, ebt_make_watchername, base, u=
base);
>> =A0 =A0 =A0 if (ret !=3D 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> - =A0 =A0 if (copy_to_user(hlp, t->u.target->name, EBT_FUNCTION_MAXNAMEL=
EN))
>> + =A0 =A0 if (copy_to_user(hlp, t->u.target->name, XT_EXTENSION_MAXNAMEL=
EN))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
>> =A0 =A0 =A0 return 0;
>> =A0}
>> --
>> 1.7.4.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe netdev" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
