Date: Wed, 28 Jul 2010 11:58:25 +0200
From: David Lamparter <equinox@diac24.net>
Message-ID: <20100728095825.GC13413@jupiter.n2.diac24.net>
References: <20100727152514.GA13413@jupiter.n2.diac24.net>
	<20100727100249.51ffc893@nehalam>
	<20100728074428.GB13413@jupiter.n2.diac24.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100728074428.GB13413@jupiter.n2.diac24.net>
Subject: [Bridge] [BUG] bridge leaks 3 references on lo per up&down
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org

On Wed, Jul 28, 2010 at 09:44:28AM +0200, David Lamparter wrote:
> On Tue, Jul 27, 2010 at 10:02:49AM -0700, Stephen Hemminger wrote:
> > David Lamparter <equinox@diac24.net> wrote:
> > > unregister_netdevice: waiting for lo to become free. Usage count = 4
> > > 
> > > unshare -n -- /bin/bash -c 'ip link add link lo veth0 type veth peer
> > > name veth3 netns 1; brctl addbr br0; ip l s br0 up; ip a l; sleep 8'

When I do

unshare -n -- /bin/bash -c 'ip link add link lo veth0 type veth peer
	name veth3 netns 1; brctl addbr br0; \
	ip l s br0 up; sleep 8; ip l s br0 down; sleep 1;
	ip l s br0 up; sleep 8;'

I get "usage count = 7" on lo; when I add another up & down, I get
"usage count = 10". 4 times makes it a merry 13 refs...


-David

