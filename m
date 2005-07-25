Date: Mon, 25 Jul 2005 09:39:37 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Making a bridge work without source address spoofing
Message-ID: <20050725093937.41f03a46@dxpl.pdx.osdl.net>
In-Reply-To: <30F5491FC3F68047925F0F51C190BCD701571028@ACDFWMAIL1.acd.de.ittind.com>
References: <30F5491FC3F68047925F0F51C190BCD701571028@ACDFWMAIL1.acd.de.ittind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Saxer, John -ACDSD" <John.Saxer@itt.com>
Cc: bridge@lists.osdl.org

On Wed, 14 Jul 2004 12:38:18 -0500
"Saxer, John -ACDSD" <John.Saxer@itt.com> wrote:

> 
> So, I agree, the curent wireless card I have been given does not
> allow source address spoofing, but I still would like to use
> bridging. I wonder if anyone has tried modifying the bridge code to
> encapsulate the actual packet in some way so that the desired source
> address can be preserved?
> 
> I am thinking of something like duplicating the ETH header, adding it
> to the beginning of the packet, so that there are 2 headers. I know
> that the wireless card strips the header off, adding its own header,
> and so it would strip off the extra one, leaving the original
> unchanged. Then, when the packet arrives, I would add software to
> strip the wireless header off again, leaving me with the original
> packet again!
> 

It won't work the data is sequential.

You could hack up a  your custom wireless driver to custom bridge code.
At which point you might as well forget bridging and just do routing
or tunneling.

> I guess I am thinking that I could add this "extra" header processing
> in the wireless driver. Do you think this might work?
> 

Why bother? The point of the bridge is to be transparent.  If you
don't want it to be transparent?
