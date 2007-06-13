Date: Wed, 13 Jun 2007 14:28:54 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Is it possible to put an aliased ethernet card on a
	bridge?
Message-ID: <20070613142854.3a572013@localhost>
In-Reply-To: <bcba51a0706131332p4aef4a38sdc9cafd726528cd9@mail.gmail.com>
References: <bcba51a0706131332p4aef4a38sdc9cafd726528cd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dimitry Golubovsky <golubovsky@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Wed, 13 Jun 2007 16:32:09 -0400
"Dimitry Golubovsky" <golubovsky@gmail.com> wrote:

> Hi,
> 
> Suppose we have two aliases of the same ethernet card:
> 
> ifconfig eth0 192.168.0.1
> ifconfig eth0:1 192.168.1.1
> 
> Is it possible to add eth0:1 to a bridge, not adding its "physical parent" eth0?
> 
> Sorry if this was answered before.
> 

You can do it, you won't get anything usable.
What are you trying to. Simple bridging is at level 2 not level 3 (IP).
