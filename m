Message-ID: <4A009943.5000505@navigue.com>
Date: Tue, 05 May 2009 15:53:39 -0400
From: Jonathan Thibault <jonathan@navigue.com>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us>		<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>		<49FA1E28.5020604@free.fr>
	<49FC4764.3030707@gmail.com>		<49FDD890.1090302@free.fr>
	<49FF41C4.4090404@gmail.com>		<49FF4AF8.1050801@free.fr>
	<49FF58EC.2090902@gmail.com>		<49FFDABF.4030500@free.fr>
	<4A007103.4010501@gmail.com>	<2e59e6970905051108q7448a0ai7f6e5cb16faf1e00@mail.gmail.com>
	<4A00915F.7000602@gmail.com>
In-Reply-To: <4A00915F.7000602@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
 connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jochen Hebbrecht <jochenhebbrecht@gmail.com>, bridge@lists.linux-foundation.org

I believe that to allow bridging on a 'client', you need to enable WDS on the interface (and likely on the AP as well).  Check to see if WDS is supported by your driver.  Basically (but I could be wrong), it is an 'ethernet over wifi' encapsulation since the wifi does not allow for mac spoofing on a client endpoint which would be required for normal bridging.

Jochen Hebbrecht wrote:
> richardvoigt@gmail.com schreef:
>> Since bridging works in Windows, your card is capable of doing this 
>> with the right configuration.  But I don't know what to suggest trying 
>> next.
> 
> Are there other places where I could get some help? I already asked it 
> at the ubuntuforums ... :-(
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

