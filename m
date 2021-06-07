Return-Path: <royujjal@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=f1Picyv92DBNFnyWc2siMe7sp2wXeSWEx4iNIZ5Pf5w=;
 b=dL07qiP7TOSZbZOSw8ZTFQlXosJ0Gy144toG1HMQyHTlWp4YQUPmaSUFHO0lwsieuh
 d8JLY1Lg25QAIh12ny6aD6fwUZJJxLDUzQ9br3xZwkWaOwSbt+A7uX1Kq/dm8CHps7l6
 ortqszK9HV3wVO+D0dUuMDY91hHI1RyM8nS6iLgoB+Myc/iNOITMFjemMokj+cci4806
 TYjNUXZ3/Z7Cmn6czunKKBUVqrR96xi1hd1La62JcZ9wzoCshtcmiyTOm0TZ3ec3fYzS
 06nCd6AbMQTC4zUANpewzOXlT3SGiAkr909gTmzaaXn/lpTlgNR7fhquopggpWpCfDjP
 LB8A==
MIME-Version: 1.0
From: Ujjal Roy <royujjal@gmail.com>
Date: Mon, 7 Jun 2021 21:29:34 +0530
Message-ID: <CAE2MWkkL9x+FRzggdOSPcyFpguwP9VuQPD9AJWLTsfLzaLodfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Bridge] net: bridge: multicast: Renaming of flag
	BRIDGE_IGMP_SNOOPING
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Kernel <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Kernel <linux-kernel@vger.kernel.org>

Hi Stephen,

Can we rename this flag BRIDGE_IGMP_SNOOPING into something like
BRIDGE_MULTICAST_SNOOPING/BRIDGE_MCAST_SNOOPING? I am starting this
thread because this BRIDGE_IGMP_SNOOPING flag holds information about
IGMP only but not about MLD. Or this is not a common name to describe
both IGMP and MLD. Please let me know about my concern, so that I can
change the code and submit a patch.

Thanks,
UjjaL Roy
