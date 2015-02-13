Return-Path: <imrep.amz@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=6O4VX+D3wwcqR3d5zZ24XbQuQGTMBIeUqgKXMuT8Rgc=;
	b=find+eg1S3BIcj/yLP2nkPoKNGrPXWn/Jjg5Ifj5Et54LhmVQGpzfxCLSRcxlGRNy9
	H4pywaugdaiXKMxKjmMkUeY0yKMG8rPZtpsyRGm8ZlbLU7xCbOtSCJ3TCoh36Ui5JskE
	EHYWI+P5NaS3J0sBxCjAOdVf0r5llc5qOWw+WCqrCGIxGz4XFeIKH65nJgofsbZGEsCF
	FfkQcH4xJMqR1EjxnjLGJ7z56aE0TH1m6V91ukWX0hSk/GakbzLUPpdE7afzwgpowQK/
	h5SFi1lKpdtGUUVekJrR+EvKxCwaSidJCOoHnbQAXSqbjBqFozOeVNQs2FFW479GEgRJ
	oQ4A==
Message-ID: <54DE2174.6040001@gmail.com>
Date: Fri, 13 Feb 2015 17:08:20 +0100
From: Imre Palik <imrep.amz@gmail.com>
MIME-Version: 1.0
References: <1423560744-19011-1-git-send-email-imrep.amz@gmail.com>
	<20150211.142936.951620487173949333.davem@davemloft.net>
In-Reply-To: <20150211.142936.951620487173949333.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: make it possible for packets to
 traverse the bridge withour hitting netfilter
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: imrep@amazon.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, aliguori@amazon.com

On 02/11/15 23:29, David Miller wrote:
> From: Imre Palik <imrep.amz@gmail.com>
> Date: Tue, 10 Feb 2015 10:32:24 +0100
> 
>> From: "Palik, Imre" <imrep@amazon.de>
>>
>> The netfilter code is made with flexibility instead of performance in mind.
>> So when all we want is to pass packets between different interfaces, the
>> performance penalty of hitting netfilter code can be considerable, even when
>> all the firewalling is disabled for the bridge.
>>
>> This change makes it possible to disable netfilter both on a per bridge basis,
>> or for the whole bridging subsystem.  In the case interesting to us, this can
>> lead to more than 10% speedup compared to the case when only bridge-iptables
>> are disabled.
>>
>> Cc: Anthony Liguori <aliguori@amazon.com>
>> Signed-off-by: Imre Palik <imrep@amazon.de>
> 
> Sorry, no.
> 
> If I apply this, someone is going to try to submit a patch for every
> damn protocol layer to add a stupid hack like this.

Actually this is one of those patches.  There is already a "stupid hack like this" for iptables and arptables.  (Implemented before git history, and giving me 10% speedup.  Many thanks, whoever did it.)

I also searched various LKML archives, and it seems the existing "stupid hacks" for iptables and arptables haven't resulted in any related patch submission in the last ten years.  (Or my google-fu is weak.)

Moreover, I cannot imagine any other reasonable on/off switch for bridge-netfilter than these three.  Of course, my imagination might be lacking there.

> Makw NF_HOOK() faster instead.

As far as I see, flexibility implies trashing the cache/TLB.  So it is impossible to have flexibility and performance at the same time.
(Except possibly with self modifying code, but that has its own set of problems.)
