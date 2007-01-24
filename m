Message-ID: <45B7A3ED.4080607@schaus.ca>
Date: Wed, 24 Jan 2007 13:22:37 -0500
From: Cameron Schaus <cam@schaus.ca>
MIME-Version: 1.0
References: <8764B2C538F2C44B845C4B608D4515D31A48C2@EXVBE012-5.exch012.intermedia.net>
In-Reply-To: <8764B2C538F2C44B845C4B608D4515D31A48C2@EXVBE012-5.exch012.intermedia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Jake Farrell <jake@amperion.com>, bridge@lists.osdl.org

Jake Farrell wrote:
>
> Recently ran into a problem with the 2.6.18 kernel on Xscale arch when 
> a bridge, with multiple interfaces on it, is configured with a 
> redundant loop. All interfaces are left on forwarding and nexer switch 
> to block when the loop is introduced. This was tested against a 2.6.16 
> kernel and the problem did not occur, interfaces forwared and blocked 
> correctly. Any help would be appreciated.
>
Since you haven't give much detail on your setup (is stp enabled on both 
bridges, for example), I'm not 100% clear what may be happening.  But it 
does sound like something I ran into before.

See my post, and Stephen's reply:
http://lists.osdl.org/pipermail/bridge/2006-December/001573.html

Cam

