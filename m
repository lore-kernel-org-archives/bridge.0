Date: Tue, 16 Feb 2010 08:31:05 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100216083105.4051667d@nehalam>
In-Reply-To: <3A71C16B9E0D7240ABBDF087E5353BCB0CB2D35BFC@ESESSCMS0354.eemea.ericsson.se>
References: <3A71C16B9E0D7240ABBDF087E5353BCB0CB2D35BFC@ESESSCMS0354.eemea.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] NTP packets not passing the bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Martin Andersson Z <martin.z.andersson@ericsson.com>
Cc: "'bridge@lists.linux-foundation.org'" <bridge@lists.linux-foundation.org>

On Tue, 16 Feb 2010 11:58:26 +0100
Martin Andersson Z <martin.z.andersson@ericsson.com> wrote:

> Hello.
> 
> I have a simple testsetup, where <node> --- | bridge | --- <node> is connected.
> 
> Every packets seems to traverse the bridge, except for the NTP packets.
> 
> When capturing on the in-port, what differes for this NTP packets is that there src-mac address is 00:00:00:00:00:00.
> Where any other packets has valid src address.
> 
> Is there a check/validation in the bridge so that it will not pass eth-packets that has a src with all 0.
> 
Yes.  all-zeros is not a valid ethernet device address.
Find and fix the hardware that is sending it.

-- 
