Date: Thu, 3 Jun 2010 08:11:54 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100603081154.58a24b35@nehalam>
In-Reply-To: <4C07B089.2080609@cfl.rr.com>
References: <4C06FE06.8040502@cfl.rr.com> <20100602194213.4147e2ce@nehalam>
	<4C07B089.2080609@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Spanning tree mapping utility
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Bridge@lists.linux-foundation.org

On Thu, 3 Jun 2010 09:39:21 -0400
Phillip Susi <psusi@cfl.rr.com> wrote:

> On 6/2/2010 10:42 PM, Stephen Hemminger wrote:
> > Open up an AF_PACKET or AF_LLC socket and receive them
> 
> Yes, I'm looking for a simple utility that does that and parses them for me.

The user mode RSTP daemon has that:
  
  git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/rstp.git
-- 
