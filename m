Message-ID: <460D5750.6030001@linux-foundation.org>
Date: Fri, 30 Mar 2007 11:30:40 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
MIME-Version: 1.0
References: <AFB2687AB4F98E419EDFA205E376D41330621A@BLR-HCLT-EVS01.HCLT.CORP.HCL.IN>
In-Reply-To: <AFB2687AB4F98E419EDFA205E376D41330621A@BLR-HCLT-EVS01.HCLT.CORP.HCL.IN>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] bridging in linux 2.4.20 kernel
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Majjari Vikram(TLS-ESG), Bangalore" <Majjari.Vikram@hcl.in>
Cc: bridge@lists.linux-foundation.org

Majjari Vikram(TLS-ESG), Bangalore wrote:

Please stop sending HTML messages, it triggers spam filters.
>
> Hi all
>
> Iam working on Bridging code in linux 2.4.20 kernel. I just want to=20
> know whether this bridge works with two different kinds of interfaces=20
> attached to bridge.
>
No
>
> Like
>
> 1. a bridge with 802.3 interface and 802.5 interface
>
No address format is different
>
> 2. a bridge with 802.3 interface and 802.16 interface(wireless).
>
No see http://linux-net.osdl.org/index.php/bridge


Wireless needs NDS support.
>
> I think the present bridge code in linux 2.4.20 kernel doesn=92t support =

> this kind of bridging and this code doesn=92t do the protocol=20
> conversions necessary. I just want to confirm.
>
> Eagerly Waiting for reply
>
> Vikram.
>
> DISCLAIMER:
> -------------------------------------------------------------------------=
----------------------------------------------
>
> The contents of this e-mail and any attachment(s) are confidential and=20
> intended for the named recipient(s) only.
> It shall not attach any liability on the originator or HCL or its=20
> affiliates. Any views or opinions presented in
> this email are solely those of the author and may not necessarily=20
> reflect the opinions of HCL or its affiliates.
> Any form of reproduction, dissemination, copying, disclosure,=20
> modification, distribution and / or publication of
> this message without the prior written consent of the author of this=20
> e-mail is strictly prohibited. If you have
> received this email in error please delete it and notify the sender=20
> immediately. Before opening any mail and
> attachments please check them for viruses and defect.
>
> -------------------------------------------------------------------------=
----------------------------------------------
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>  =20

