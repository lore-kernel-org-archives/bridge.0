Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iFsgbsnFgsbhPnlwLkM/14implnwlgFFSCTSxq+tcOw=; b=zkki5Y4g8r/noSSk8K8IMG45Dk
 ABEzJAmZy53zZSiAiqq06tQWxQUDcE9CUBbSbL9pfMZStX/PZRiXzT39drwbUYMd2NfyC1enPFhHj
 vESZVSEWGOnAyt8s9fgFKY5i0ORHuMm+V2LShbCvmICvbmgdmSV0QGvM8GHbssEJkxps=;
Date: Sun, 19 Apr 2020 18:42:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20200419164251.GM836632@lunn.ch>
References: <20200419161946.19984-1-dqfext@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419161946.19984-1-dqfext@gmail.com>
Subject: Re: [Bridge] [RFC PATCH net-next] net: bridge: fix client roaming
 from DSA user port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: DENG Qingfang <dqfext@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>, =?iso-8859-1?Q?Ren=E9?= van Dorst <opensource@vdorst.com>, Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

On Mon, Apr 20, 2020 at 12:19:46AM +0800, DENG Qingfang wrote:
> When a client roams from a DSA user port to a soft-bridged port (such as WiFi
> interface), the left-over MAC entry in the switch HW is not deleted, causing
> inconsistency between Linux fdb and the switch MAC table. As a result, the
> client cannot talk to other hosts which are on that DSA user port until the
> MAC entry expires.
> 
> Solve this by notifying switchdev fdb to delete the leftover entry when an
> entry is updated. Remove the added_by_user check in DSA
> 
> Signed-off-by: DENG Qingfang <dqfext@gmail.com>
> ---
> I tried this on mt7530 and mv88e6xxx, but only mt7530 works.
> In previous discussion[1], Andrew Lunn said "try playing with auto learning
> for the CPU port" but it didn't work on mv88e6xxx either

Hi Deng

We should probably first define how we expect moving MAC to work. Then
we can make any core fixes, and driver fixes.

For DSA, we have assumed that the software bridge and the hardware
bridge are independent, each performs its own learning. Only static
entries are kept in sync.

How should this separate learning work for a MAC address which moves?

    Andrew
