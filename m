Date: Thu, 21 Aug 2003 11:46:31 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] kernel BUG in skb_checksum_help
Message-Id: <20030821114631.604dfd6f.shemminger@osdl.org>
In-Reply-To: <lhoeyj2uc5.fsf@dodo.bluetail.com>
References: <lhoeyj2uc5.fsf@dodo.bluetail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bridge-admin@lists.osdl.org
Errors-To: bridge-admin@lists.osdl.org
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge/>
To: Luke Gorrie <luke@member.fsf.org>
Cc: bridge@osdl.org

On 21 Aug 2003 12:11:54 +0200
Luke Gorrie <luke@member.fsf.org> wrote:

> Ahoy,
> 
> Can anyone shed some light on the kernel BUG() below? We're getting it
> when bridging certain NICs, e.g. the onboard 100Mbps Intel ports on a
> Dell 1550. It seems easily provoked by pinging an IP broadcast
> address.
> 
> I've seen almost identical reports in the list archive, and that the
> problem was attributed to driver bugs. If this is correct, can someone
> explain what the bugs were? We'd like to fix this for the drivers that
> we're using.
> 

Just a guess, but maybe the NIC is doing hardware assisted checksum
normally, and doesn't bother to set the skb->csum field on incoming
packets. Then when they go through filtering and need to be re-checksummed
it blows up.  You could try turning off hw checksumming (via ethtool) 
