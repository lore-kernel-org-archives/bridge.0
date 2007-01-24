Date: Wed, 24 Jan 2007 11:19:12 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070124111912.7c72de7f@freekitty>
In-Reply-To: <8764B2C538F2C44B845C4B608D4515D31A48C6@EXVBE012-5.exch012.intermedia.net>
References: <8764B2C538F2C44B845C4B608D4515D31A48C2@EXVBE012-5.exch012.intermedia.net>
	<45B7A3ED.4080607@schaus.ca>
	<8764B2C538F2C44B845C4B608D4515D31A48C6@EXVBE012-5.exch012.intermedia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] STP Loop not blocking
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Jake Farrell <jake@amperion.com>
Cc: bridge@lists.osdl.org

On Wed, 24 Jan 2007 10:46:48 -0800
"Jake Farrell" <jake@amperion.com> wrote:

> The setup is as follows
> 
> ixp4xx #1:  br0 (eth0, eth1, ath0, ath1) STP enabled
>                   |                 |
>                   |                 |
>                   |                 |
> ixp4xx #2:  br0 (eth0, eth1, ath0, ath1) STP enabled
> 
> with 2.6.16 one of the interfaces goes to blocking and the other is left to forward. In 2.6.18 the interfaces always stay forwarding.
> 
> Jake
> 
> 
> >
> > Recently ran into a problem with the 2.6.18 kernel on Xscale arch when 
> > a bridge, with multiple interfaces on it, is configured with a 
> > redundant loop. All interfaces are left on forwarding and nexer switch 
> > to block when the loop is introduced. This was tested against a 2.6.16 
> > kernel and the problem did not occur, interfaces forwared and blocked 
> > correctly. Any help would be appreciated.
> >
> Since you haven't give much detail on your setup (is stp enabled on both 
> bridges, for example), I'm not 100% clear what may be happening.  But it 
> does sound like something I ran into before.
> 
> See my post, and Stephen's reply:
> http://lists.osdl.org/pipermail/bridge/2006-December/001573.html
> 
> Cam

There haven't been a huge number of bridge changes, perhaps
STP got broken. Git bisect to a particular changeset would help

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
