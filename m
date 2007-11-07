Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [Bridge] Lowering CPU utilisation
Date: Wed, 7 Nov 2007 13:20:48 +1100
Message-ID: <96CF49BD8B56384395D698BA99007FA32D25@exchange.pacwire.local>
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


> Did you remember to configure NAPI for the e1000 driver (it is
optional).

As far as I can tell, it's on by default. A 'make menuconfig' shows "Use
Rx Polling (NAPI)" as being enabled.
 

  

-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@linux-foundation.org] 
Sent: Wednesday, 7 November 2007 9:19 AM
To: Leigh Sharpe
Cc: Vaidas M; bridge@lists.linux-foundation.org
Subject: Re: [Bridge] Lowering CPU utilisation

On Wed, 7 Nov 2007 08:51:41 +1100
"Leigh Sharpe" <lsharpe@pacificwireless.com.au> wrote:

> I'm using e1000 cards.
> According to oprofile, around 50% of the time is spent in the e1000
> driver. 
> Given that my load average is still under 0.5, I suspect I've got
plenty
> of room for the driver to handle more traffic before I need to worry
too
> much.
>  
>
Did you remember to configure NAPI for the e1000 driver (it is
optional).

-- 
Stephen Hemminger <shemminger@linux-foundation.org>

