From: Shankar_Natarajan@emc.com
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Fri, 7 Jul 2006 16:36:10 -0400
Message-ID: <E5D4309543B4664CA745472C48D4F724045AE250@CORPUSMX50A.corp.emc.com>
In-Reply-To: <20060707114611.6a5e988b@dxpl.pdx.osdl.net>
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] bridge+filter+failover+rules&state sync+traffic shaping
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: shemminger@osdl.org
Cc: bridge@lists.osdl.org



> -----Original Message-----
> From: bridge-bounces@lists.osdl.org
[mailto:bridge-bounces@lists.osdl.org]
> On Behalf Of Stephen Hemminger
> Sent: Friday, July 07, 2006 11:46 AM
> To: Tristan DEFERT
> Cc: bridge@lists.osdl.org
> Subject: Re: [Bridge] bridge+filter+failover+rules&state sync+traffic
> shaping
> 
> On Tue, 27 Jun 2006 16:11:01 +0200
> Tristan DEFERT <tristan.d@alphamosa.fr> wrote:
> 
> > hi list!
> > i'm trying to find a convenient way to build a redundant filtering
> > bridge under linux
> >
> > i looked at carp project, but carp doesn't support bridge
> >
> > now i thing the most appropriate way is using stp or rstp
> > it seems that 2.6 kernel supports stp but what about rstp?
> 
> The 2.6.18 kernel has hooks to allow building STP protocols in user
land.
> There is a student working on RSTP as a Google Summer of Code project.

Is there a customary wary of posting/watching status/progress on this
RSTP work? How is the work progressing? Any dates that can be shared?

I'd like to volunteer my team to be an early consumer and test the
implementation when it is ready. Possible? 

Thanks,
Shankar

 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge

