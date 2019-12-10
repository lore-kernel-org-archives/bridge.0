Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KLN1DYREPXJpHHYubJRCZWT4Wl8rGRaKmxfqjHjWjvk=;
 b=iwzzrNTlkY94RCl4TChdZktFq7Pjb6pT5dQseFy7qH0h/JLXalF6dHolaBGhxLQowT
 dhz8TdjxRX29eMgwexF1fgI4Dlu7dA21zBBPkUCSJ9ejdaYLt4WLnLR+fiyw03Y2Sp+i
 cRhJK+g+J5khXtcocNbBzQtmz0/UDXF0FJqizj5S/Y3cWDPkSUjYg9OXegRsjMXXZrKN
 PgsXyI/vAt0lNtWHzlJdHS8Bl8xDKpW+lnQnOylhE/ugKIdNnm5npTUXKnElwHpf0Ju/
 +XE2Z+YQvJVFA5mMUMyFmgFtvrX26pi/NGYuAduda4ekrD33xvogSecQOX4kf6DKr9gk
 FWnQ==
Date: Mon, 9 Dec 2019 16:13:45 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20191209161345.5b3e757a@hermes.lan>
In-Reply-To: <20191209230522.1255467-2-vivien.didelot@gmail.com>
References: <20191209230522.1255467-1-vivien.didelot@gmail.com>
 <20191209230522.1255467-2-vivien.didelot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH iproute2 v2] iplink: add support for STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vivien Didelot <vivien.didelot@gmail.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On Mon,  9 Dec 2019 18:05:22 -0500
Vivien Didelot <vivien.didelot@gmail.com> wrote:

> Add support for the BRIDGE_XSTATS_STP xstats, as follow:
> 
>     # ip link xstats type bridge_slave dev lan5
>                         STP BPDU:
>                           RX: 0
>                           TX: 39
>                         STP TCN:
>                           RX: 0
>                           TX: 0
>                         STP Transitions:
>                           Blocked: 0
>                           Forwarding: 1
>                         IGMP queries:
>                           RX: v1 0 v2 0 v3 0
>                           TX: v1 0 v2 0 v3 0
>     ...

Might I suggest a more concise format:
	STP BPDU:  RX: 0 TX: 39
	STP TCN:   RX: 0 TX:0
	STP Transitions: Blocked: 0 Forwarding: 1
...
