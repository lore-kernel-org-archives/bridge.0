Message-ID: <20040616221223.12615.qmail@web90110.mail.scd.yahoo.com>
Date: Wed, 16 Jun 2004 15:12:23 -0700 (PDT)
From: Derek Smalls <dsmalls321@yahoo.com>
Subject: Re: [Bridge] Bridging between user processes
In-Reply-To: <40D08A26.1040907@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Thanks for the response!

Running the application produces the same result (no
result actually) as ping -I. Looks like tcpdump can
see the tap  interfaces: tcpdump on tap4 can see
outgoing pings sent out on tap4. Moreover, I can send
pings through the bridge and tcpdump on tap4 picks
them up. 

I guess in order to bridge between taps I really do
need a separate utility that would copy frames between
/dev/tap4 and /dev/tap5 .  

--- "John W. Linville" <linville@tuxdriver.com> wrote:
> Derek Smalls wrote:
> 
> > I then do a ping over tap4: 
> > 
> >>ping -I tap4 8.8.8.8 
> 
> > and tcpdump on tap5: 
> > 
> >>tcpdump -i tap5 
> 
> > and see nothing. Shouldn't I see the ping requests
> on
> > tap5 now? 
> 
> My guess is that your `ping -I` is completely
> bypassing the bridging 
> code.  I haven't looked at it lately, but I'd guess
> that the bridging 
> functionality is geared toward receiving frames on
> the "slave" interface 
> and transmitting frames through the "master"
> interface.  You example is 
> transmitting on the "slave" interface (to use my
> terminology).
> 
> A better test would be to setup your bridge, then
> start the application 
> you mentioned on the transmitting side and monitor
> the other side for 
> traffic (probably with another instance of your
> application).
> 
> BTW, I don't think tcpdump will be useful.  You'll
> need something that 
> is "tap-aware".
> 
> Good luck!
> 
> John
> 



		
__________________________________
Do you Yahoo!?
Take Yahoo! Mail with you! Get it on your mobile phone.
http://mobile.yahoo.com/maildemo 
