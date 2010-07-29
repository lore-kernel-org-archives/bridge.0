Date: Thu, 29 Jul 2010 17:39:00 +0200
From: Rodolfo Giometti <giometti@enneenne.com>
Sender: giometti@enneenne.com
Message-ID: <20100729153900.GF9056@enneenne.com>
References: <20100702135641.GQ2149@gundam.enneenne.com>
	<20100702092148.5d5a4e57@nehalam>
	<20100727092655.GA30692@gundam.enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100727092655.GA30692@gundam.enneenne.com>
Subject: Re: [Bridge] rstpd & 2.4
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

On Tue, Jul 27, 2010 at 11:26:55AM +0200, Rodolfo Giometti wrote:

> Regarding the bridge controls I can add to the current sysfs interface
> the old ioctl interface as the old bridge-utils did.

Hello, I ported almost everything but I'm stuck on function
STP_OUT_flush_lt (file bridge_track.c).

In file rstplib/topoch.c I read:

/*
 * In many kinds of hardware the function
 * STP_OUT_flush_lt is a) is very hard and b) cannot
 * delete learning emtries per port. The alternate
 * method may be used: we don't care operEdge flag here,
 * but clean learning table once for TopologyChange
 * for all ports, except the received port. I am ready to discuss :(
 * See below word STRONGLY_SPEC_802_1W
 */

So I suppose this function is currently disabled. Is that true?

If not, can you please give me advice in order to backport the above
function to the old ioctl() interface? It is not so clear to me what
exactly that function does... :(

Thanks in advance,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
