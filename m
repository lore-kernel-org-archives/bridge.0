Date: Wed, 9 Jun 2010 08:23:19 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100609082319.67bfb897@nehalam>
In-Reply-To: <OFAE56C1D1.3B4E5ED6-ONC125773D.005039AB-C125773D.00511E25@transmode.se>
References: <OFAE56C1D1.3B4E5ED6-ONC125773D.005039AB-C125773D.00511E25@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge responds on its IP address even when br0 is
 down.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: bridge@lists.linux-foundation.org

On Wed, 9 Jun 2010 16:46:01 +0200
Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:

> 
> System A:
> eth0 has ip 192.168.1.16
> 
> Then do in system A
> brctl addbr br0
> ifconfig br0 192.168.1.18 down
> 
> 
> From system B I ping 192.168.1.18
> and system A responds!
> 
> Even though interface br0 is down I can still
> access system A with 192.168.1.18, this feels
> like a bridge bug?
> 

No that is how Linux works. All addresses are property of the
system not the interface.
   http://en.wikipedia.org/wiki/Host_model
