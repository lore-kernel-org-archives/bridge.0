Message-ID: <460C8BA5.5060407@osdl.org>
Date: Thu, 29 Mar 2007 21:01:41 -0700
From: Stephen Hemminger <shemminger@osdl.org>
MIME-Version: 1.0
References: <AFB2687AB4F98E419EDFA205E376D4132C7CFB@BLR-HCLT-EVS01.HCLT.CORP.HCL.IN>
In-Reply-To: <AFB2687AB4F98E419EDFA205E376D4132C7CFB@BLR-HCLT-EVS01.HCLT.CORP.HCL.IN>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Static filtering entries in bridging -- linux 2.4.20
 kernel
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
>    2. how to make group MAC addresses (multicast addresses) in bridging.
>
You don't need to. All mulitcasts are forwarded automatically as per
802.1d spec.

>  
>
> Eagerly waiting for reply.
>

