Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=4g/6cFmwE4ZLqr3Bzgu4/ccE9kGgU0mb5darvXALrY4=;
	b=MjJu1xE6CwtYoKfrUsBeCrudfnjiJHH28yTgksbN+qyJzfS3n8LIths/i1J1ddDuJX
	8hxDT3sSNd3kHa1PuTOCckxC/2fIkEcfGdfMTMJzC2vWnUZcDfTjRgWR0L2zHsTCAgqk
	BRyDluL0YixPg+WL6RugDiLXUB0zCBX7D6d9E=
References: <1513087370-4791-1-git-send-email-nikolay@cumulusnetworks.com>
	<20171212100224.1aa33a96@xeon-e3>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <77f67d9a-8fef-0758-fdbe-9db7555f32d6@cumulusnetworks.com>
Date: Tue, 12 Dec 2017 20:18:19 +0200
MIME-Version: 1.0
In-Reply-To: <20171212100224.1aa33a96@xeon-e3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: use rhashtable for fdbs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, srn@prgmr.com

On 12/12/17 20:02, Stephen Hemminger wrote:
> On Tue, 12 Dec 2017 16:02:50 +0200
> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
> 
>> +		memcpy(__entry->addr, f->key.addr.addr, ETH_ALEN);
> 
> Maybe use ether_addr_copy() here?
> 

This is an unrelated cleanup, the code in question was already like that. I can post
a separate patch to turn these into ether_addr_copy().
 
