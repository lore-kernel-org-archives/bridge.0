Return-Path: <sergei.shtylyov@cogentembedded.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=ezRVcm6S3L0WbYpSjhKW5aqe3yFZAQUSVlcOw5N5JaU=;
	b=nN7Lt46Gu3qaj31WDxhnpBoJd97jn1ivPNtf6vXCQEEwL6QKjkOQ8EGz8/bBPgiFy1
	bSyG7kPOuhtVwT4oqyM9Ysgb7nlGeacjoT1+lKH9sI72/NCRaj57h0iBmxBcp59UNYUV
	cPYvHNuSWz82dLIPFsyhxtZqj5zSzlS2KnVzfJ3lIPoDFURl63LJ/exECQbaRsoPZjyC
	KtZaEJEhitQBDVGmKaLKDmaHpCcfCnvP2QgEK/NPBn1NoMb//naYX3OvpmQGd5CK48F2
	wYvUU14xE7WotzJlkTrw+Ohd1ANRV/vFgGdaf8/LHGi/nKnzpImwdNyqhHomOSqAdCiE
	DyYA==
References: <1472267428-810527-1-git-send-email-green@linuxhacker.ru>
	<11e50e3c-2e1f-4614-07e3-3bd144af4f94@cogentembedded.com>
	<95BF7F27-59F7-4BDA-941B-BB00C60423A4@linuxhacker.ru>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <59758948-d899-a32f-12af-a56b8c0da6c1@cogentembedded.com>
Date: Sat, 27 Aug 2016 19:18:16 +0300
MIME-Version: 1.0
In-Reply-To: <95BF7F27-59F7-4BDA-941B-BB00C60423A4@linuxhacker.ru>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH] bridge: Fix format string for %ul
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

Hello.

On 8/27/2016 6:58 PM, Oleg Drokin wrote:

>>> %ul would print an unsigned value and a letter l,
>>> likely it was %lu that was meant to print the long int,
>>> but in reality the values printed there are just regular signed
>>
>>   Signed? Then you need probably "%d" or "%i"…
>
> They are signed in the struct definition, but in reality they
> designate time, so could not be negative, I imagine?

    That doesn't matter. If the type is signed, it should be printed as signed.
Doesn't gcc complain about the format specifiers not matching the values passed?

>>> ints, so just dropping the l altogether.
>>>
>>> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
>> [...]

MBR, Sergei

