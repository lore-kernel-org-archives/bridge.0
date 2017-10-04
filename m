Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=uw4O7MqRRH6cjz2l6gKUwYcEyZ2QUkzUVsKtVcx8rjI=;
	b=mZmMn6v+jyVFq6LE8sQEoQPCMcREcYBbxccgehmz7Os7iDLMP7vXOuyIN748uFCZjA
	FusniR3VNhik5BL+CoWXpwd9puyrCbLeGfK4JrCc40fGh1HQdma8eCF7ZHgEeXQPFLlX
	UPSFPFo2Pcs7NsGLhXOupC1niZuRfNmzlZWahfSVvcnCHkB3Pahq6HJ8RtfFLoVVje0W
	MWo4rnV9GMSX8o+A5aFvof40WyN7/15CZ5Q1aG8nLODAmAuBsNojeeLZv0mbY329U5og
	afhKbaRoSju3Elw70OIlsUwsamBsct/5oEHFZ64WMVy/EzQ6YxK9Z23iF6Q3U3KGlmGs
	fb7w==
References: <1507093134-20406-1-git-send-email-dsahern@gmail.com>
	<1507093134-20406-7-git-send-email-dsahern@gmail.com>
	<20171004081357.37bfd941@xeon-e3>
From: David Ahern <dsahern@gmail.com>
Message-ID: <fc657f3d-0a6d-1df1-6373-e170dbdbee25@gmail.com>
Date: Wed, 4 Oct 2017 09:16:20 -0700
MIME-Version: 1.0
In-Reply-To: <20171004081357.37bfd941@xeon-e3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 6/7] net: bridge: Pass extack to down
 to netdev_master_upper_dev_link
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, vfalico@gmail.com, j.vosburgh@gmail.com, davem@davemloft.net

On 10/4/17 8:13 AM, Stephen Hemminger wrote:
> On Tue,  3 Oct 2017 21:58:53 -0700
> David Ahern <dsahern@gmail.com> wrote:
> 
>> Pass extack arg to br_add_if. Add messages for a couple of failures
>> and pass arg to netdev_master_upper_dev_link.
>>
>> Signed-off-by: David Ahern <dsahern@gmail.com>
> 
> This looks good. You might want to pass the netlink_ext_ack down as
> an immutable pointer (const).

Can't mark extack as const. The NL_SET_ERR_MSG sets _msg to the passed
in string.

> 
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> 

