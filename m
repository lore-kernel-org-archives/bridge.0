Date: Wed, 10 Jun 2009 07:45:42 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090610074542.39f713eb@nehalam>
In-Reply-To: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] RFC: Simple Private VLAN impl.
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

On Wed, 10 Jun 2009 15:32:06 +0200
Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:

> 
> Even though some folks on this list thinks ebtables should be used
> to deploy Private VLAN I find using ebtables a bit clumsy.
> 

I prefer ebtables be used to "patch" bridge to do these kind
of special case things.  Remember any code that is put in mainline
adds additional API's and long term support burden.
