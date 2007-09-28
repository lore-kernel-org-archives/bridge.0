DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
	bh=7WAg9GVLrhto7+edABBHXw6I7YX37OCDxhSqj+WC+wc=;
	b=L22257v1UmDIdiKCvzANe95nLmwZhOlm1bzlVeV0c8DSpSYp2/oHsdLOc5ptADPwqlpofatrqQ/3jhmmRoFcScRrl36/79LRB1J/wx11HVMxquDV+jAzlc69kL54LhpxT2C14xAKC8ic6ceLsTQzXZaXfGP62qJyDJPfBEf+d+M=
Message-ID: <46FCEF57.4080007@googlemail.com>
Date: Fri, 28 Sep 2007 14:11:03 +0200
From: Dennis Borgmann <dennis.borgmann@googlemail.com>
MIME-Version: 1.0
Subject: Re: [Bridge] Flushing MAC-tables(?)
References: <46FCB3F4.4080802@googlemail.com>
	<46FCBC98.6030507@sysnetsistemi.it>
In-Reply-To: <46FCBC98.6030507@sysnetsistemi.it>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Francesco Dolcini <fdolcini@sysnetsistemi.it>
Cc: bridge@lists.linux-foundation.org

Hi Francesco,

I already tried playing around with the ageing timer, but it did not
help me.

Since I am using Kernel 2.4: is there no way of flushing the FDB?

Thanks so far,
Dennis


Francesco Dolcini schrieb:
> Dennis Borgmann wrote:
>> So at a certain point of time, there seems to be a flushing of some
>> bridge-tables, but I don't know, how I could influence this behaviour.
>> Is this "flushing" somehow to be done manually? Or is there a timer,
>> which sets this behaviour?
> in recent kernel (not in 2.4, and maybe only in recent 2.6) you can
> flush the FDB using sysfs:
> /sys/class/net/%s/bridge/flush (whole bridge)
> /sys/class/net/%s/brif/%s/flush (single interface)
>
> If you want you can lower the ageing timer from the default 300sec
> using brcl setageing
>
> Maybe you can just force your phone to register more frequently so the
> bridge will just learn the new port when you move.
>
> Francesco
>

