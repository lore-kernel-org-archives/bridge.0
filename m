Date: Wed, 10 Aug 2011 08:11:38 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20110810081138.3a1b2632@nehalam.ftrdhcpuser.net>
In-Reply-To: <6680AE1BD102B9419251E785D19F5D039FA037F0@ExchN1.riedel.net>
References: <6680AE1BD102B9419251E785D19F5D039FA037F0@ExchN1.riedel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] possible bridge regression in "bridge: implement
 [add/del]_slave ops"?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Weirich, Bernhard" <Bernhard.Weirich@riedel.net>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

On Wed, 10 Aug 2011 09:54:58 +0200
"Weirich, Bernhard" <Bernhard.Weirich@riedel.net> wrote:

> Hello,
> 
> I had trouble with the new detection code for interface ports. 
> In turned out that the carrier was down, but IFF_RUNNING was set. 
> I changed the code to check for IFF_UP & IFF_LOWER_UP for interface ports and now it works the way it should.
> Would it be better to check IFF_LOWER_UP or is my interface device driver incorrect?
> 
> Best regards,
> Bernhard

The standard for carrier up is IFF_RUNNING. IFF_LOWER_UP is meant for
use by modems and other special devies.
