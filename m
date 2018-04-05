Return-Path: <nbd@nbd.name>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vGLrIukY07gRATQZHyZ1+a4Hq4EsEQk1eM1dMM8MSpQ=;
	b=rzar7c0SKRxYZLIDjnKZ/JStUy
	zpA7U6xJKHx1N/KfMDH3YNMEdS9LNFMPTq/sApDRtF4o8Uxj0EF4BS6cFGjbFV0pnNzkRiskC8U6A
	jC50wd6B2FuAz7tOZYUu+VVCdQrQEbtUa9q2sAHhjQcFw5oTeiB5XSF/y4d86WAqeink=; 
References: <cover.1522479607.git.joe@perches.com>
	<e0ab9616-64fa-cdbc-7a77-7e25d70c1a52@nbd.name>
	<1522936292.11185.15.camel@perches.com>
From: Felix Fietkau <nbd@nbd.name>
Message-ID: <999e4ee7-2e4e-6bf9-ac76-209e259c83e4@nbd.name>
Date: Thu, 5 Apr 2018 16:05:51 +0200
MIME-Version: 1.0
In-Reply-To: <1522936292.11185.15.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH 00/12] Ethernet: Add and use ether_<type>_addr
	globals
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joe Perches <joe@perches.com>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Cc: brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org, brcm80211-dev-list@cypress.com

On 2018-04-05 15:51, Joe Perches wrote:
>>  You have to factor in
>> not just the .text size, but the fact that referencing an exported
>> symbol needs a .reloc entry as well, which also eats up some space (at
>> least when the code is being built as module).
> 
> Thanks, the modules I built got smaller.
Please post some numbers to show this. By the way, on other
architectures the numbers will probably be different, especially on
ARM/MIPS.
>> In my opinion, your series probably causes more bloat in common
>> configurations instead of reducing it.
>> 
>> You're also touching several places that could easily use
>> eth_broadcast_addr and eth_zero_addr. I think making those changes would
>> be more productive than what you did in this series.
> 
> Doubtful. AFAIK: possible unaligned addresses.
Those two are just memset calls, alignment does not matter.

- Felix
