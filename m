Message-ID: <8135BF451955D5119DE200203567D82A060ED4D5@ge-muc-exch-01.azlan.ger>
From: Josef Brunner <Josef.Brunner@azlan.com>
Subject: RE: [Bridge] bridge firewall problem
Date: Tue, 2 Aug 2005 12:12:23 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: 'Vinay Sharma ' <vinaysharma2k@yahoo.com>
Cc: "'bridge@lists.osdl.org'" <bridge@lists.osdl.org>

hi,

funny, I will be in chennai from tommorrow for two weeks.

ok, no problem. just have a look at this website that offers some easy
examples. Using these examples you could block ip as well as arp (mac)
traffic. 

http://ebtables.sourceforge.net/examples.html#easy

if you have further questions, just shout.

josef


-----Original Message-----
From: Vinay Sharma
To: Josef Brunner
Sent: 8/2/2005 12:59 PM
Subject: RE: [Bridge] bridge firewall problem

hi josef,
   i am a new to ebtables.
      i am facing some problems they are..
           
1   we r a internet service provider.  we distribute
internet in india(Delhi). here cable operators
distribute internet via cables we provides the net
connection to thest cable operators and they
distribute it to the users via cables.  
   our network fully on radios(wireless) we distribute
it by point-to-point connection.  here one cable
operator take more then three connections and want to
our subscribe.  when i give to him connection via
radio(point-to-point) when he put my line to his local
distribution switch  our radio hangs after 15 minutes.
    to solve this i setup a linux bridge firewall . in
machine i wrote rules in iptables but iptables didnt
block other traffic
    i want to give access to only
172.16.18.0/255.255.255.0 this series.
            but my firewall passes all the traffic
whenever i take any ip of any series.

           someone give me advice to use ebtables so i
installed fedora core 3 version and installed
ebtables-2.0.6-7.fc4 and my kernel version is 

kernel-2.6.9-1.667   i think that it has the support
of ebtables.  


 pls give me some examble to block ip series or mac
address in bridge via using ebtables or iptables
  


thaks and ragard
   vinay


--- Josef Brunner <Josef.Brunner@Azlan.com> wrote:

> hi,
> 
> what error occurs ? does your kernel support
> ebtables ? Do you have a
> userland problem ? Pls. deliver some more details
> regarding your problem.
> 
> josef
> 
> -----Original Message-----
> From: Vinay Sharma
> To: bridge@lists.osdl.org
> Sent: 8/2/2005 12:38 PM
> Subject: [Bridge] bridge firewall problem
> 
> hello 
>             i am a new user for this group. i am
> working at a ISP. here i want to made a  bridge
> firewall i am using fedora core 3. i want to block a
> serirs of ip address 192.16.18.0/255.255.255.0 and
> want to give the accesss only
> 172.16.18.0/255.255.255.0.  but iptables not be able
> to block ip;s its passes all the ip series. i made
> my
> machine as bridge. i think my bridge passes all the
> traffic i want to block unathorized traffic by
> 192.16.18.0/255.255.255.0. someone advise me for
> using
> ebtables for that and i installed that but i am not
> able to use ebtables.
> 
> 
>  pls advised me
> 
> Vinay sharma
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam
> protection around 
> http://mail.yahoo.com 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
> 
>
________________________________________________________________________
_______
> Disclaimer
> 
> This message may contain confidential information
> solely for its
> intended recipients and others may not distribute,
> copy or use it. If
> you have received this communication in error please
> tell us either by
> return e-mail or at the numbers above and delete it,
> and any copies of
> it.
> 
> 


Vinay sharma



		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
