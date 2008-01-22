Message-ID: <4795B507.4090705@satca.net>
Date: Tue, 22 Jan 2008 10:19:03 +0100
From: Marian Jancar <m.jancar@satca.net>
MIME-Version: 1.0
References: <478E102C.8050006@satca.net>
	<2e59e6970801212158s42350483n75941bb4f58124a5@mail.gmail.com>
In-Reply-To: <2e59e6970801212158s42350483n75941bb4f58124a5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: MAC addresses on ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: bridge@lists.linux-foundation.org

richardvoigt@gmail.com wrote:
> I'm pretty sure you have it nailed except for one thing... what is all
> this "higher than" another MAC address?  There's no ordering defined
> for MAC addresses, and it wouldn't matter anyway, in my experience the
> bridge takes the MAC address of the lowest-numbered port, that is the
> first one added to the bridge, without regard for the addresses.

It used to take the lowest MAC address (and effectively changing it when
you added new port with lower MAC that it had), but it seems to be changed
recently.

Marian
