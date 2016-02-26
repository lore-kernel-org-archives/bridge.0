Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=zilnCHgwJ06a2hU8dhLBDFSMW1te3be13LffOxfjN78=;
	b=bcpiQMQt12AcSf4+aakz/I4rDIDkB3Ol2sVral6/AE3Y/AOKeL71nG1DO9pY8krymR
	7CtNeyrh6pb0/IGV0NW/HH0hhzN5psq/Uxu8fgDtPMLCurj5auMkL1pu2ZM1JRfoJFRJ
	zR2GhCNID406YCNqc/wJRYpGHl9N6fGs/KkSQ=
References: <1456513166-20159-1-git-send-email-nikolay@cumulusnetworks.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <56D0ACB4.5020000@cumulusnetworks.com>
Date: Fri, 26 Feb 2016 20:51:16 +0100
MIME-Version: 1.0
In-Reply-To: <1456513166-20159-1-git-send-email-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/3] bridge: mcast: add support for
 temp router port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 02/26/2016 07:59 PM, Nikolay Aleksandrov wrote:
> Hi,
> This set adds support for temporary router port which doesn't depend on
> the incoming queries. It can be refreshed by setting multicast_router to
> the same value (3). The first two patches are minor changes that prepare
> the code for the third which adds this new type of router port.
> In order to be able to dump its information the mdb router port format
> is changed and extended similar to how mdb entries format was done
> recently.
> The related iproute2 changes will be posted if this is accepted.
> 
> Thanks,
>  Nik
> 

Self-NAK, spotted an minor issue with the val setting I've missed.
Will post v2 after some more testing.

Thanks,
 Nik


