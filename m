Return-Path: <vyasevich@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=kazT3c6nnHpI/bWN4VrsMWBBnrYNTfHQmlOOAV+hD+Q=;
	b=uvs6E/pIIMdOQ28Pa/kFQG+kMVt8omgW+UP7Wxx+4/b8m34rbn2s9KmYrPj4weJizw
	vv0RVIP/VdJUROW+fmdpC62tbuaGn9lLzAOGQRYlyijfaARZLujYQFY0ZG5FxWLItCmm
	Rgcw09pfpAs/4Gh2+VPfB8MHLsA8i9XhcTTUn0syx9cXhwD1QNNPnNbWBsmYBOdimsxm
	tnn8UZVdZaxMSgUw0earL6sea651HDOJ7Xi/8Z/ZWudMaag4QGcWWnAbT6dr56LLbUhw
	a3+cET1+lcwmdZSE7HjpjzdKxGgbTvCkyTBCCTJO90HmxsQbPB+dz4JMOICLeadRSNMd
	rjXg==
Message-ID: <5391CC89.1030104@gmail.com>
Date: Fri, 06 Jun 2014 10:13:29 -0400
From: Vlad Yasevich <vyasevich@gmail.com>
MIME-Version: 1.0
References: <1401969212-19193-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20140605.152151.1874961526019573838.davem@davemloft.net>
	<063D6719AE5E284EB5DD2968C1650D6D1725853E@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1725853E@AcuExch.aculab.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next] bridge: Fix incorrect judgment of
	promisc
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Laight <David.Laight@ACULAB.COM>, 'David Miller' <davem@davemloft.net>, "makita.toshiaki@lab.ntt.co.jp" <makita.toshiaki@lab.ntt.co.jp>
Cc: "stephen@networkplumber.org" <stephen@networkplumber.org>, "vyasevic@redhat.com" <vyasevic@redhat.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>

On 06/06/2014 04:48 AM, David Laight wrote:
> From: David Miller [mailto:davem@davemloft.net]
>>> br_manage_promisc() incorrectly expects br_auto_port() to return only 0
>>> or 1, while it actually returns flags, i.e., a subset of BR_AUTO_MASK.
>>>
>>> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>>
>> I'm applying this as-is for now, even though I saw the other
>> suggestions in this thread (which BTW didn't get picked up by
>> patchwork, maybe some of you dropped the Message-Id in your replies by
>> accident).
> 
> I don't have a problem with that.
> The condition looks odd, but it is enabling promiscuous mode
> if any other ports are in 'auto' mode.

No, the condition is correct and explicit.  The cases are:
  0 auto ports == all ports are statically configured and non-promisc.
  1 auto port == only this port can be non-promisc.  all others promisc.
  > 1 auto port == all ports promisc.

-vlad

> Possibly the comment above made that clear, but it was truncated
> in the diffs.
> 
> 	David
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

