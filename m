Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=GzXTZN2s6naNL26BfTVBl1E41kNnvnYHrab5sokz8+M=;
	b=BXmkXzAzNPcXJbRd957IIlm3XIl8OpDPx6dDCjyj7OXo21lKhTOhVWVl5mN4aA/UaN
	fgCvqt0L1OQ0FyRNNLmOhXxsEUKu7c1MjSpNIhGI1Mzf63SSnVumuHW6XDIR8t2BSoNo
	DRj7qwmYaT7PVXk1jPDkNkZAAe/k8xnUcQUko=
References: <20180621201427.4961-1-garrmcnu@gmail.com>
	<20180622.072056.1223319763674661318.davem@davemloft.net>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <e4fb2883-1643-a921-a138-d1255831a9bd@cumulusnetworks.com>
Date: Fri, 22 Jun 2018 02:35:29 +0300
MIME-Version: 1.0
In-Reply-To: <20180622.072056.1223319763674661318.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: bridge: fix potential null pointer
 dereference on return from br_port_get_rtnl()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>, garrmcnu@gmail.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jiri@resnulli.us, linux-kernel@vger.kernel.org

On 06/22/2018 01:20 AM, David Miller wrote:
> From: Garry McNulty <garrmcnu@gmail.com>
> Date: Thu, 21 Jun 2018 21:14:27 +0100
> 
>> br_port_get_rtnl() can return NULL if the network device is not a bridge
>> port (IFF_BRIDGE_PORT flag not set). br_port_slave_changelink() and
>> br_port_fill_slave_info() callbacks dereference this pointer without
>> checking. Currently this is not a problem because slave devices always
>> set this flag. Add null check in case these conditions ever changye.
>>
>> Detected by CoverityScan, CID 1339613 ("Dereference null return value")
>>
>> Signed-off-by: Garry McNulty <garrmcnu@gmail.com>
> 
> I don't think this is reasonable.
> 
> The bridge code will never, ever, install a slave that doesn't have
> that bit set.  It's the most fundamental aspect of how these objects
> are managed.
> 
+1

This keeps coming up, here's the previous one:
https://patchwork.ozlabs.org/patch/896046/

Please do a more thorough check if these conditions can actually occur.
In this case, as Dave said, they cannot.

To be explicit as with the patch I mentioned above:
Nacked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

You can find more info in my reply to the patch above.

Thanks,
 Nik
