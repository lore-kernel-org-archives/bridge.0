Message-ID: <20040617222940.79616.qmail@web90104.mail.scd.yahoo.com>
Date: Thu, 17 Jun 2004 15:29:40 -0700 (PDT)
From: Derek Smalls <dsmalls321@yahoo.com>
Subject: Re: [Bridge] Bridging between user processes - TAP question
In-Reply-To: <40D11F57.9070504@web.de>
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

Thanks again to everybody who responded!

I've redone everything from scratch with no result, I
think I'm missing something with respect to tap
devices -- hopefully this is the forum to get help.

I'm trying to write a trivial application that would
do read/write between a pair of tap devices. For
starters I'm just trying to do a read on a single tap
device -- just to make sure that it works. On a
freshly booted 2.4.20 system I do:

>tunctl -u root -t tap0
>mknod /dev/tap0 c 36 16 
>ifconfig tap0 promisc up

BTW, "tunctl" does not create the /dev/tap0 file so I
am using "mknod" to do it -- is this correct? 

I then start a very simple program derived from the
example in tun-1.1 package to do a select on
"/dev/tap0":

int main(int argc, char *argv[]) 
{ 
   int f1, fm; 
   fd_set fds; 
  
   f1 = open("/dev/tap0", O_RDWR); 
   ioctl(f1, TUNSETNOCSUM, 1); 
   fm = f1 + 1; 
  
   FD_ZERO(&fds); 
   FD_SET(f1, &fds); 
  
   select(fm, &fds, NULL, NULL, NULL); 
  
   printf("Received data on tap0 \n"); 
   return 0; 
} 

I then do "ping -I tap0 6.6.6.6" , or start my own
application that talks to ethernet ports giving it
tap0 as the port to talk to... Nothing. The select()
never returns. BTW, tcpdump does show packets on tap0
in both cases.

I suspect that tap0 is not set up correctly, what am I
doing wrong?

Thank you,


--- Michael Renzmann <mrenzmann@web.de> wrote:
> Hi.
> 
> Derek Smalls wrote:
>  >>I have not played with tun/tap myself, but the
>  >>kernel documentation in
>  >>Documentation/networking/tuntap.txt seems to
>  >>indicate that you need a program to listen on two
>  >>opened /dev/net/tun devices and copy the frames
>  >>from one to the other.
> > Thanks! I was afraid this was the reason ... :(
> > 
> > I actually tried writing an application that would
> > open /dev/tap4 as a file and do a select() on it. 
> 
> The standalone tun-package [1] contains two example
> applications that 
> act as simple bridges, one using SIGIO, one using
> select(). I guess it 
> could be helpful for you to take a look at these
> examples.
> 
> [1] http://vtun.sourceforge.net/tun/tun-1.1.tar.gz
> 
> Bye, Mike
> 



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - Helps protect you from nasty viruses.
http://promotions.yahoo.com/new_mail
