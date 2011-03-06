Message-ID: <4D73CC04.6060909@computer.org>
Date: Sun, 06 Mar 2011 19:01:40 +0100
From: Jan Ceuleers <jan.ceuleers@computer.org>
MIME-Version: 1.0
References: <20110306051833.GA3098@mira.lan.galacticasoftware.com>
	<1154832100.13939.1299393783798.JavaMail.root@tahiti.vyatta.com>
	<20110306080328.GA3850@mira.lan.galacticasoftware.com>
In-Reply-To: <20110306080328.GA3850@mira.lan.galacticasoftware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/2] Issue NETDEV_CHANGE notification when
 bridge changes state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Adam Majer <adamm@zombino.com>
Cc: "Pekka Savola (ipv6)" <pekkas@netcore.fi>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, James Morris <jmorris@namei.org>, Stephen Hemminger <stephen.hemminger@vyatta.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "David S. Miller" <davem@davemloft.net>

On 06/03/11 09:03, Adam Majer wrote:
> On Sat, Mar 05, 2011 at 10:43:03PM -0800, Stephen Hemminger wrote:
>> Why not set forwarding delay to zero? I don't think you are using STP?
 >
> No, I'm not relying on STP. I think setting learning->forwarding delay
> to 0 could cause problems with STP like loops until the loop is
> detected.

I don't think that Stephen is saying that you should hard-code the 
forwarding delay as zero (i.e. to remove the delay from the kernel 
completely), but rather use brctl to set the forwarding delay to zero on 
bridge instances in which you're not using STP.

HTH, Jan

