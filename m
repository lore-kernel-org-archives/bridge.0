Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Date: Fri, 30 Mar 2007 10:36:43 +0530
Message-ID: <AFB2687AB4F98E419EDFA205E376D41330618C@BLR-HCLT-EVS01.HCLT.CORP.HCL.IN>
From: "Majjari Vikram(TLS-ESG), Bangalore" <Majjari.Vikram@hcl.in>
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] Static filtering entries in bridging -- linux
	2.4.20kernel
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.linux-foundation.org



Hi all

I think Static filtering entries are needed in bridging for security
purposes. I read that we can add static filtering entries in to the
bridge filtering database. The entry information includes the
destination MAC address and the port number(other fields as required)so
that when a packet/frame arrives with the destination mac address that
was specified in static filtering entry the frame gets bridged/forwarded
to the interface/port that we have specified in the table(as a static
filtering entry).



-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@osdl.org] 
Sent: Friday, March 30, 2007 9:32 AM
To: Majjari Vikram(TLS-ESG), Bangalore
Cc: bridge@lists.linux-foundation.org
Subject: Re: [Bridge] Static filtering entries in bridging -- linux
2.4.20kernel

Majjari Vikram(TLS-ESG), Bangalore wrote:
>
> Hi all
>
>             Iam working on bridging in linux 2.4.20 kernel. can any 
> one help me on these questions.
>
2.4 code is in stable (dormant) mode, major bug fixes only.

>  
>
>    1. how to make static filtering entries and
>

Bridging in linux does not have a way to add static entries. Why do you 
need them?
>
>   1.
>
>
>    2. how to make group MAC addresses (multicast addresses) in
bridging.
>
You don't need to. All mulitcasts are forwarded automatically as per
802.1d spec.

>  
>
> Eagerly waiting for reply.
>


DISCLAIMER:
-----------------------------------------------------------------------------------------------------------------------

The contents of this e-mail and any attachment(s) are confidential and intended for the named recipient(s) only.
It shall not attach any liability on the originator or HCL or its affiliates. Any views or opinions presented in 
this email are solely those of the author and may not necessarily reflect the opinions of HCL or its affiliates.
Any form of reproduction, dissemination, copying, disclosure, modification, distribution and / or publication of 
this message without the prior written consent of the author of this e-mail is strictly prohibited. If you have
received this email in error please delete it and notify the sender immediately. Before opening any mail and 
attachments please check them for viruses and defect.

-----------------------------------------------------------------------------------------------------------------------

